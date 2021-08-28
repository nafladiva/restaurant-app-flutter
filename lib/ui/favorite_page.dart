import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restail/provider/db_provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<DBProvider>(context).favorites;
    return Scaffold(
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
                'Your Favorites',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Column(
              children: favorites.length > 0
                  ? favorites.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 7.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail',
                                arguments: item.id_restaurant);
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
                                    padding: const EdgeInsets.only(left: 16.0),
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
                                                  child:
                                                      Icon(Icons.location_pin),
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
                    }).toList()
                  : [
                      Column(
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
                              'No favorite?',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Text(
                              "You are not choosing your favorite restaurant yet! Let's choose which restaurant that you love",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Let's go"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFEA82F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
