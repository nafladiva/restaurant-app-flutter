import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/provider/restaurant_list_provider.dart';
import 'package:restail/widgets/error.dart';

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService(Client())),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFFFC107).withOpacity(0.7),
                      child: IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Restaurant List',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return Column(
                      children: state.result.restaurants.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 7.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: item.id);
                            },
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://restaurant-api.dicoding.dev/images/small/' +
                                                  item.pictureId),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 16.0,
                                                ),
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(
                                                        Icons.location_pin),
                                                  ),
                                                  TextSpan(text: item.city),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x7FC4C4C4),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 430.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 68.0, horizontal: 28.0),
                            child: Image.asset('images/nodata.png'),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Restaurant not found',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Let's search another restaurant!",
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Search again'),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFEA82F),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state.state == ResultState.Error) {
                    return ErrorScreen();
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
