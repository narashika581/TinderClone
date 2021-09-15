import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/date_screen.dart';
import 'package:tinder_clone/src/models/gender_type.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/school.dart';
import 'package:tinder_clone/src/service.dart';

class ShowScreen extends StatefulWidget {
  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  GenderType _selectedButton;

  void initState() {
    super.initState();
    _selectedButton = null;
  }

  @override
  Widget build(BuildContext context) {
    var _service = Provider.of<TinderService>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.grey[50],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Show me",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 40),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      border:
                                          (_selectedButton == GenderType.WOMAN)
                                              ? Border.all(
                                                  color: Colors.red, width: 2)
                                              : Border.all(color: Colors.black),
                                      color: Colors.grey[50]),
                                  child: TextButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent)),
                                    onPressed: () {
                                      setState(() {
                                        _selectedButton = GenderType.WOMAN;
                                      });
                                    },
                                    child: Text(
                                      "WOMAN".toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (_selectedButton ==
                                                GenderType.WOMAN)
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: (_selectedButton == GenderType.MAN)
                                        ? Border.all(
                                            color: Colors.red, width: 2)
                                        : Border.all(color: Colors.black),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedButton = GenderType.MAN;
                                      });
                                    },
                                    style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent)),
                                    child: Text(
                                      "MAN".toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            (_selectedButton == GenderType.MAN)
                                                ? Colors.red
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      border: (_selectedButton ==
                                              GenderType.PRIVATE)
                                          ? Border.all(
                                              color: Colors.red, width: 2)
                                          : Border.all(color: Colors.black),
                                      color: Colors.grey[50]),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedButton = GenderType.PRIVATE;
                                      });
                                    },
                                    style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent)),
                                    child: Text(
                                      "EVERYONE".toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: (_selectedButton ==
                                                GenderType.PRIVATE)
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: (_selectedButton != null)
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
                        color: Colors.grey[200]),
                    child: TextButton(
                      onPressed: () {
                        _service.user.interested = _selectedButton;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SchoolScreen()));
                      },
                      child: Text(
                        "Continue".toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
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
