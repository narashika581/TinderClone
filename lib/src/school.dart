import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/date_screen.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/passion_screen.dart';
import 'package:tinder_clone/src/service.dart';

class SchoolScreen extends StatefulWidget {
  @override
  _SchoolScreenState createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  TextEditingController controllerFName;
  bool _isButtonActives;

  void initState() {
    super.initState();
    controllerFName = TextEditingController();
    _isButtonActives = false;
  }

  @override
  Widget build(BuildContext context) {
    var _service = Provider.of<TinderService>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "My \nschool is",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 40),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
                              child: TextField(
                                onChanged: (s) {
                                  if (s.length > 0) {
                                    setState(() {
                                      _isButtonActives = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isButtonActives = false;
                                    });
                                  }
                                },
                                controller: controllerFName,
                                onTap: () {},
                                decoration: InputDecoration(
                                  hintText: 'School Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                  "This is how it will appear in Tinder and you will not be able to change it"),
                            ),
                          ],
                        ),
                      ),
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
                        gradient: (_isButtonActives ?? false)
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
                      onPressed:
                          (_isButtonActives || controllerFName.text != "")
                              ? () {
                                  if (!_isButtonActives ||
                                      controllerFName.text == "") {
                                    return;
                                  }
                                  _service.user.school = controllerFName.text;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PassionScreen()));
                                }
                              : null,
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
