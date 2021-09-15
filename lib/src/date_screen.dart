import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/choose_gender.dart';
import 'package:tinder_clone/src/date_screen.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';

class DateScreen extends StatefulWidget {
  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  int selectedAge = 18;
  TextEditingController controllerFName;
  bool _isButtonActives;

  void initState() {
    super.initState();
    selectedAge = 18;
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "My  \nage is",
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
                            SizedBox(
                              height: 5.0,
                            ),
                            NumberPicker(
                              value: selectedAge,
                              minValue: 18,
                              maxValue: 70,
                              onChanged: (value) =>
                                  setState(() => selectedAge = value),
                            ),
                            Text(
                              "Your age will be public",
                            )
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
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepOrange[300],
                            Colors.pink[300],
                            Colors.pink[400]
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        color: Colors.grey[50]),
                    child: TextButton(
                      onPressed: () {
                        _service.user.age = selectedAge;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => GenderScreen()));
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
