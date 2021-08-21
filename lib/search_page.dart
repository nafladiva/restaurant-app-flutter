import 'package:flutter/material.dart';

import 'model/restaurant.dart';

class SearchPage extends StatefulWidget {
  final String search;

  const SearchPage({required this.search});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Result for',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  widget.search,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                final List<Restaurant> restaurant =
                    parseRestaurant(snapshot.data);
                var searchResult = restaurant.where((item) => item.name
                    .toLowerCase()
                    .contains(widget.search.toLowerCase()));
                return Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 14.0),
                  child: Column(
                    children: searchResult.isNotEmpty
                        ? searchResult.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 7.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/detail',
                                      arguments: item);
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
                                              image:
                                                  NetworkImage(item.pictureId),
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
                                              Text(item.city),
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
                            SizedBox(
                              height: 430.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 68.0, horizontal: 28.0),
                                child: Image.asset('images/noresult.png'),
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
