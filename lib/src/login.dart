import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/home_root_screen.dart';
import 'package:tinder_clone/src/house_rules.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerUsername;
  TextEditingController controllerPassword;
  bool _isButtonActives;

  void initState() {
    super.initState();
    controllerUsername = TextEditingController();
    controllerPassword = TextEditingController();
    _isButtonActives = false;
  }

  @override
  Widget build(BuildContext context) {
    var _service = Provider.of<TinderService>(context);
    void login(String password, String username, BuildContext ctxt) async {
      var resp = await _service.login(password, username);
      if (resp == null) {
        return;
      }
      if (resp.code != 200) {
        ScaffoldMessenger.of(ctxt).showSnackBar(SnackBar(
          content: Text(resp.error ?? "Facing some weird problem"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
        return;
      }
      if (resp.result == null) {
        return;
      }
      if (resp.result.registered ?? false) {
        Navigator.of(ctxt).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreenRoot()),
            (Route<dynamic> route) => false);
      } else {
        _service.user = User()..id = username;
        Navigator.of(ctxt)
            .push(MaterialPageRoute(builder: (_) => HouseRules()));
      }
    }

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
              Text(
                "Login",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
                child: TextField(
                  onChanged: (s) {
                    var state = false;
                    if (s.length > 0 && controllerPassword.text.length > 0) {
                      state = true;
                    }
                    setState(() {
                      _isButtonActives = state;
                    });
                  },
                  controller: controllerUsername,
                  onTap: () {},
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
                child: TextField(
                  autocorrect: false,
                  controller: controllerPassword,
                  onChanged: (s) {
                    var statez = false;
                    if (s.length > 0 && controllerUsername.text.length > 0) {
                      statez = true;
                      print("yolo");
                    }
                    setState(() {
                      _isButtonActives = statez;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
              Text("*Terms and Conditions apply"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: (_isButtonActives)
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
                        login(controllerPassword.text, controllerUsername.text,
                            context);
                      },
                      child: Text(
                        "LOGIN".toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              (_isButtonActives) ? Colors.white : Colors.grey,
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
