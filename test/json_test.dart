import 'package:flutter_test/flutter_test.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/data/model/restaurant.dart';

const testRestaurantList = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

const testRestaurantSearch = {
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

void main() {
  group('Json Parse test', () {
    test('verify that restaurant list json parsed as expected', () async {
      final data = await ApiService().getRestaurantList();
      final testData = Restaurant.fromJson(testRestaurantList);

      var result = data.restaurants[0];

      expect(result.id == testData.id, true);
      expect(result.name == testData.name, true);
      expect(result.description == testData.description, true);
      expect(result.pictureId == testData.pictureId, true);
      expect(result.city == testData.city, true);
      expect(result.rating == testData.rating, true);
    });

    test('verify that restaurant search json parsed as expected', () async {
      final data = await ApiService().search('kafein');
      final test = RestaurantSearch.fromJson(testRestaurantSearch);

      var result = data.restaurants[0];
      var testData = test.restaurants[0];

      expect(result.id == testData.id, true);
      expect(result.name == testData.name, true);
      expect(result.description == testData.description, true);
      expect(result.pictureId == testData.pictureId, true);
      expect(result.city == testData.city, true);
      expect(result.rating == testData.rating, true);
    });
  });
}
