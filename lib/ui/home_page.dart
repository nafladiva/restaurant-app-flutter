import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/data/model/restaurant.dart';
import 'package:restail/provider/db_provider.dart';
import 'package:restail/provider/restaurant_list_provider.dart';
import 'package:restail/utils/notification_helper.dart';
import 'package:restail/widgets/error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bigText = 'What restaurant you want to go today?';
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject('/dashboard');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<DBProvider>(context).favorites;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(apiService: ApiService(Client())),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(52),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x7fC4C4C4),
                      spreadRadius: 7,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hello there!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/settings');
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TweenAnimationBuilder<int>(
                          builder:
                              (BuildContext context, int value, Widget? child) {
                            return Text(
                              _bigText.substring(0, value),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            );
                          },
                          duration: Duration(seconds: 5),
                          tween: IntTween(begin: 0, end: _bigText.length),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: TextField(
                          onSubmitted: (value) {
                            Navigator.pushNamed(context, '/result',
                                arguments: value);
                          },
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            filled: true,
                            fillColor: Color(0xFFF9F6F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    List<Restaurant> topRestaurants = [
                      ...state.result.restaurants
                    ];
                    topRestaurants
                        .sort((a, b) => (b.rating).compareTo(a.rating));
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          child: Text(
                            'Top Restaurant',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 130,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: topRestaurants.take(3).map((item) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/detail',
                                        arguments: item.id);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 200,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://restaurant-api.dicoding.dev/images/small/' +
                                                        item.pictureId),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 200,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 18.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                item.city,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 7.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0,
                                                        horizontal: 7.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange[400],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                ),
                                                child: Text(
                                                  item.rating.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your Favorites',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/favorites');
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 180,
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              scrollDirection: Axis.horizontal,
                              children: favorites.length > 0
                                  ? favorites.take(3).map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/detail',
                                                arguments: item.idRestaurant);
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            width: 130,
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8.0)),
                                                      child: Container(
                                                        width: 130,
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                'https://restaurant-api.dicoding.dev/images/small/' +
                                                                    item.pictureId),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 6.0,
                                                            right: 6.0),
                                                    child: Text(
                                                      item.name,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  item.city,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x7FC4C4C4),
                                                  spreadRadius: 3,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              57.0,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 170.0),
                                              child: Text(
                                                'You are not choosing your favorite yet!',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/bg_fav.png'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                        ),
                                      ),
                                    ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Restaurant List',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/list');
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 180,
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              scrollDirection: Axis.horizontal,
                              children: state.result.restaurants
                                  .skip(5)
                                  .take(3)
                                  .map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/detail',
                                          arguments: item.id);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      width: 130,
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                                child: Container(
                                                  width: 130,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://restaurant-api.dicoding.dev/images/small/' +
                                                              item.pictureId),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 8.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Text(
                                                    item.rating.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0x7FFFC107),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(4.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 6.0,
                                                  right: 6.0),
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'OpenSans',
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            item.city,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x7FC4C4C4),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.asset('images/nodata.png'),
                          ),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'made with \u2764 by Nafla',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
