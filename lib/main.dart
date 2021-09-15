import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tinder_clone/src/env.dart';
import 'package:tinder_clone/src/home_root_screen.dart';
import 'package:tinder_clone/src/login.dart';
import 'package:tinder_clone/src/photos_screen.dart';
import 'package:tinder_clone/src/service.dart';
import 'package:tinder_clone/src/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/storage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FlutterStorage>(create: (_) => FlutterStorage()),
        // Provider<http.Client>(create: (_) => HttpUniversalClient.client()),
        Provider<TinderService>(
          create: (ctxt) {
            return TinderService(
              httpEndpoint,
              wsEndpoint,
              Provider.of<FlutterStorage>(ctxt, listen: false),
            );
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: StartScreen(),
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctxt) => StartProvider(context),
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Colors.deepOrange[300],
                  Colors.pink[300],
                  Colors.pink[400]
                ])),
            child: Consumer<StartProvider>(builder: (ctxt, provider, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: ImageIcon(
                                AssetImage("assets/img/logo.png"),
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "tinder",
                              style: TextStyle(fontSize: 50),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // child: Container(
                    // width: 100,
                    // height: 100,
//                child: ImageIcon(
                    //                AssetImage("assets/img/logo.png"),
                    //            ),
                    //        ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Center(
                      child: Text(
                        "By clicking log in, you agree with our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Sign in with email".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )))),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            "Sign up with email".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "Trouble Logging in ?",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }
}

class StartProvider with ChangeNotifier {
  BuildContext ctxt;
  TinderService _service;
  String error;
  Timer callback = null;

  StartProvider(BuildContext context) {
    this.ctxt = context;
    _service = Provider.of<TinderService>(context, listen: false);
    error = "Connecting to Servers...";
    fetchData();
  }

  void fetchData() async {
    callback = null;
    error = "Connecting to Servers...";
    notifyListeners();
    var res = await _service.me();
    if (res.code == 500) {
      error = "Unable to establish network connection";
      callback = Timer(Duration(seconds: 5), fetchData);
      notifyListeners();
      return;
    }

    if (res.code == 200) {
      Navigator.of(ctxt).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreenRoot()),
          (Route<dynamic> route) => false);
      return;
    }
    error = null;
    notifyListeners();
  }
}
