import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/data/model/restaurant.dart';

import 'json_test.mocks.dart';

const responseList = {
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

const testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

const responseSearch = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "uewq1zg2zlskfw1e867",
      "name": "Kafein",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "15",
      "city": "Aceh",
      "rating": 4.6
    }
  ]
};

const testSearch = {
  "id": "uewq1zg2zlskfw1e867",
  "name": "Kafein",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  "pictureId": "15",
  "city": "Aceh",
  "rating": 4.6
};

@GenerateMocks([ApiService])
void main() {
  RestaurantResult restaurantResult;
  RestaurantSearch restaurantSearch;

  ApiService apiService = MockApiService();
  when(apiService.getRestaurantList())
      .thenAnswer((_) async => RestaurantResult.fromJson(responseList));
  when(apiService.search('kafein'))
      .thenAnswer((_) async => RestaurantSearch.fromJson(responseSearch));

  group('Json Parse test', () {
    test('verify that restaurant list json parsed as expected', () async {
      restaurantResult = await apiService.getRestaurantList();
      var data = Restaurant.fromJson(testRestaurant);

      expect(restaurantResult.restaurants[0].id, data.id);
      expect(restaurantResult.restaurants[0].name, data.name);
      expect(restaurantResult.restaurants[0].description, data.description);
      expect(restaurantResult.restaurants[0].pictureId, data.pictureId);
      expect(restaurantResult.restaurants[0].city, data.city);
      expect(restaurantResult.restaurants[0].rating, data.rating);
    });

    test('verify that restaurant search json parsed as expected', () async {
      restaurantSearch = await apiService.search('kafein');
      var data = Restaurant.fromJson(testSearch);

      expect(restaurantSearch.restaurants[0].id, data.id);
      expect(restaurantSearch.restaurants[0].name, data.name);
      expect(restaurantSearch.restaurants[0].description, data.description);
      expect(restaurantSearch.restaurants[0].pictureId, data.pictureId);
      expect(restaurantSearch.restaurants[0].city, data.city);
      expect(restaurantSearch.restaurants[0].rating, data.rating);
    });
  });
}
