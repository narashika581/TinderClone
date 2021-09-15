import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/edit_profile.dart';
import 'package:tinder_clone/src/service.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _service = Provider.of<TinderService>(context);
    var bytes = base64.decode(_service.user.images[0]);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          width: size.width,
          height: size.height * 0.60,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 10,
              // changes position of shadow
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: MemoryImage(bytes), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  _service.user.name.toUpperCase() +
                      ", " +
                      _service.user.age.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 10,
                                  blurRadius: 15,
                                  // changes position of shadow
                                ),
                              ]),
                          child: IconButton(
                            onPressed: () {
                              Provider.of<TinderService>(context, listen: false)
                                  .logout();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
                            },
                            icon: Icon(
                              Icons.logout,
                              size: 35,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Log out",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.withOpacity(0.8)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            width: 85,
                            height: 85,
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFfc3973),
                                          Color(0xFFfd5f60)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 10,
                                          blurRadius: 15,
                                          // changes position of shadow
                                        ),
                                      ]),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 0,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 10,
                                            blurRadius: 15,
                                            // changes position of shadow
                                          ),
                                        ]),
                                    child: Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "ADD MEDIA",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 10,
                                  blurRadius: 15,
                                  // changes position of shadow
                                ),
                              ]),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => EditProfile()));
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 35,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "EDIT INFO",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.withOpacity(0.8)),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
