import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name;
  String college;
  int age;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.grey[50],
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (z) {
                            name = z;
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (z) {
                            age = int.parse(z);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your Age',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (z) {
                            college = z;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your College',
                          ),
                        ),
                      ),
                    ],
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
                          color: Colors.grey[200]),
                      child: TextButton(
                        onPressed: () async {
                          var ret = await Provider.of<TinderService>(context,
                                  listen: false)
                              .updateProfile(
                                  name ?? '', age ?? 0, college ?? '');
                          if (ret.code == 200) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "SAVE CHANGES".toUpperCase(),
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
      ),
    );
  }
}
