import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/first_name.dart';
import 'package:tinder_clone/src/service.dart';
import 'package:tinder_clone/src/sign_up.dart';

class HouseRules extends StatelessWidget {
  Widget card(String title, String des) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: RadiantGradientMask(
                    child: Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextSpan(
                  text: "\t ${title}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
          child: Text(
            des,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<TinderService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Center(
              child: ImageIcon(
                AssetImage("assets/img/logo.png"),
                size: 50,
                color: Colors.red,
              ),
            ),
          ),
          Center(
              child: Text(
            "Welcome to Tinder.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 25,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "Please follow these House Rules.",
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey),
            )),
          ),
          SizedBox(
            height: 20,
          ),
          card("Be yourself.",
              "Make sure your photos, age and bio are true to who you are."),
          card("Stay Safe",
              "Don't be too quick to give out personal information"),
          card("Play it cool",
              "Respect others and treat then as you would like to be treated"),
          card("Be proactive", "Always report bad behaviour"),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: (true)
                            ? LinearGradient(
                                colors: [
                                  Colors.deepOrange[300],
                                  Colors.pink[300],
                                  Colors.pink[400]
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              )
                            : null,
                        color: Colors.grey[50]),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FirstNameScreen()));
                      },
                      child: Text(
                        "I AGREE".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepOrange[300], Colors.pink[300], Colors.pink[400]],
      ).createShader(bounds),
      child: child,
    );
  }
}
