import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/data/model/restaurant.dart';
import 'package:restail/provider/db_provider.dart';
import 'package:restail/provider/restaurant_detail_provider.dart';
import 'package:restail/widgets/error.dart';

class DetailRestaurant extends StatelessWidget {
  final String restaurantId;
  late bool _isFavorite = false;

  DetailRestaurant({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<DBProvider>(context).favorites;

    for (var fav in favorites) {
      if (fav.id_restaurant == restaurantId) {
        _isFavorite = true;
      }
    }

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
          apiService: ApiService(), restaurantId: restaurantId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              Map<String, dynamic> restaurant = state.result.restaurants;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 300.0,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://restaurant-api.dicoding.dev/images/small/' +
                                          restaurant['pictureId']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 220.0, left: 30.0, right: 30.0),
                              height: 160.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x7FC4C4C4),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color(0xFFFFC107).withOpacity(0.7),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        if (_isFavorite == false) {
                                          final favorite =
                                              RestaurantFavorite.fromMap({
                                            'id_restaurant': restaurantId,
                                            'name': restaurant['name'],
                                            'pictureId':
                                                restaurant['pictureId'],
                                            'city': restaurant['city'],
                                          });

                                          Provider.of<DBProvider>(context,
                                                  listen: false)
                                              .addFavorite(favorite);
                                        } else {
                                          Provider.of<DBProvider>(context,
                                                  listen: false)
                                              .deleteFavorite(restaurantId);
                                        }
                                        _isFavorite = !_isFavorite;
                                      },
                                      icon: Icon(
                                        _isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 240),
                              child: Center(
                                child: Text(
                                  restaurant['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 275),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        child: Icon(Icons.location_pin),
                                      ),
                                      TextSpan(text: restaurant['city']),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 310),
                              child: Center(
                                child: Text(
                                  restaurant['address'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 335),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7.0),
                                decoration: BoxDecoration(
                                  color: Colors.orange[400],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Text(
                                    restaurant['rating'].toString(),
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 28.0),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  'Categories',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  for (var item in restaurant['categories'])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFEA82F),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 16.0),
                                          child: Text(
                                            item['name'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  'Description',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                restaurant['description'],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  'Reviews',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Column(
                                children: [
                                  for (var item
                                      in restaurant['customerReviews'])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFFF2F2F2),
                                                spreadRadius: 5,
                                                blurRadius: 10,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 55.0,
                                                      child: CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:
                                                            AssetImage(
                                                                'images/pp.png'),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item['name'],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        item['date'],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 14.0),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Text(
                                                  item['review'],
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 90.0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox.expand(
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.1,
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      builder: (BuildContext context, scroll) {
                        return Container(
                          padding: EdgeInsets.only(
                              top: 0, left: 20.0, right: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEA82F),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x7fC4C4C4),
                                spreadRadius: 7,
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: ListView(
                            controller: scroll,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: Text(
                                  'Menu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  'Food',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  for (var item in restaurant['menus']['foods'])
                                    Container(
                                      padding: EdgeInsets.all(12.0),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      width: double.infinity,
                                      child: Text(
                                        item['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF9F6F7),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 25.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  'Drink',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  for (var item in restaurant['menus']
                                      ['drinks'])
                                    Container(
                                      padding: EdgeInsets.all(12.0),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      width: double.infinity,
                                      child: Text(
                                        item['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF9F6F7),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else if (state.state == ResultState.NoData) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Image.asset('images/nodata.png'),
                    SizedBox(
                      height: 14.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Oops!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Text(
                      'We cannot find the data you looking for :(',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.state == ResultState.Error) {
              return ErrorScreen();
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
