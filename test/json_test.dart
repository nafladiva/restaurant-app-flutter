import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

import 'json_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  RestaurantResult restaurantResult;
  RestaurantSearch restaurantSearch;
  ApiService apiService;

  group('[Json Parse test]', () {
    final client = MockClient();
    apiService = ApiService(client);

    test('verify that get restaurant list response is a RestaurantResult',
        () async {
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));

      expect(await apiService.getRestaurantList(), isA<RestaurantResult>());
    });

    test(
        'verify that get restaurant detail response is a RestaurantResultDetail',
        () async {
      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","restaurant": {}}', 200));

      expect(await apiService.getDetail('rqdv5juczeskfw1e867'),
          isA<RestaurantResultDetail>());
    });

    test('verify that get restaurant search response is a RestaurantSearch',
        () async {
      when(client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/search?q=kafein')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "founded": 1, "restaurants": []}', 200));

      expect(await apiService.search('kafein'), isA<RestaurantSearch>());
    });

    test('verify that restaurant list json parsed as expected', () async {
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));

      restaurantResult = await apiService.getRestaurantList();

      expect(restaurantResult.count, 20);
    });

    test('verify that restaurant search json parsed as expected', () async {
      when(client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/search?q=kafein')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "founded": 1, "restaurants": []}', 200));

      restaurantSearch = await apiService.search('kafein');

      expect(restaurantSearch.error, false);
      expect(restaurantSearch.founded, 1);
    });
  });
}
