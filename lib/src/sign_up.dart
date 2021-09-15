import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/house_rules.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';

class UserProvider with ChangeNotifier {
  BuildContext ctxt;
  TinderService _service;
  User user;
  bool isLoginEnabled = false;

  UserProvider(BuildContext context) {
    this.ctxt = context;
    _service = Provider.of<TinderService>(context, listen: false);
  }
  RegExp usernameRegExp = RegExp(r"^(?!\s*$)[a-zA-Z0-9-_]{2,50}$");
  String username = "", password = "";

  _validateForm() {
    isLoginEnabled = password.length > 0 && usernameRegExp.hasMatch(username);
    notifyListeners();
  }

  void _onSignUpButtonPress(BuildContext context) async {
    var resp = await _service.register(this.password, this.username);
    if (resp == null) {
      return;
    }
    if (resp.code == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Internet is unavailable"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      notifyListeners();
      return;
    } else if (resp.code == 409) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resp.error),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    if (resp.code != 200) {
      return;
    }

    _service.user ??= User()..id = username;
    _service.user.id = username;
    print(_service.user.id);
    print(username);
    notifyListeners();
    Navigator.of(ctxt)
        .pushReplacement(MaterialPageRoute(builder: (_) => HouseRules()));
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _service = Provider.of<TinderService>(context);
    return ChangeNotifierProvider(
      create: (context) => UserProvider(context),
      child: GestureDetector(
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
            child: Consumer<UserProvider>(
              builder: (ctxt, provider, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 10),
                    child: TextField(
                      onChanged: (s) {
                        provider.username = s;
                        provider._validateForm();
                      },
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
                      onChanged: (s) {
                        provider.password = s;
                        provider._validateForm();
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
                            gradient: (provider.isLoginEnabled)
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
                            provider._onSignUpButtonPress(context);
                          },
                          child: Text(
                            "register".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: (provider.isLoginEnabled)
                                  ? Colors.white
                                  : Colors.grey,
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
        ),
      ),
    );
  }
}
