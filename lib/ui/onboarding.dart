import 'package:flutter/material.dart';
import 'package:restail/data/model/onboarding_content.dart';
import 'package:restail/ui/home_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int current = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6F7),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  current = index;
                });
              },
              itemBuilder: (_, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 72.0, horizontal: 32.0),
                        child: Center(
                          child: Image.asset(
                            contents[index].image,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          contents[index].title,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 32.0),
                      child: Text(
                        contents[index].desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(contents.length, (index) => buildDot(index))),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (current == contents.length - 1) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              child: Text(
                current == contents.length - 1 ? 'Start' : 'Next',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF971D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      width: current == index ? 30 : 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFEA82F),
      ),
    );
  }
}
