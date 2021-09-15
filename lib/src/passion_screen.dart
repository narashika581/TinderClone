import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/date_screen.dart';
import 'package:tinder_clone/src/models/passion_type.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/photos_screen.dart';
import 'package:tinder_clone/src/service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/house_rules.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';

class PassionProvider with ChangeNotifier {
  BuildContext ctxt;
  TinderService _service;
  User user;
  bool isLoginEnabled = false;
  List<PassionType> passions = [];
  PassionProvider(BuildContext context) {
    this.ctxt = context;
    _service = Provider.of<TinderService>(context, listen: false);
  }
  void toggle(PassionType p) {
    if (passions?.contains(p) ?? false) {
      passions.remove(p);
    } else {
      if (passions == null) {
        passions = [p];
      } else {
        if (passions?.length == 5 ?? false) {
          return;
        }
        passions.add(p);
      }
    }
    notifyListeners();
  }
}

class PassionScreen extends StatefulWidget {
  @override
  _PassionScreenState createState() => _PassionScreenState();
}

class _PassionScreenState extends State<PassionScreen> {
  List<String> passions;

  void initState() {
    super.initState();
    passions ??= [" hello"];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PassionProvider(context),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text(
                    "Passions",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 30),
                  child: Text(
                    "Let everyone know what you're passionate about by adding it to your profile.",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PassionRow(
                          passions: [
                            PassionType.Anime,
                            PassionType.Astrology,
                            PassionType.Baking
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Athlete,
                            PassionType.Baking,
                            PassionType.Brunch,
                            PassionType.Foodie,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Golf,
                            PassionType.Potterhead,
                            PassionType.Vlogging,
                            PassionType.Musician,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Chemistry,
                            PassionType.Cricket,
                            PassionType.DogLover,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Gamer,
                            PassionType.Climbing,
                            PassionType.Hiking,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Bollywood,
                            PassionType.Cycling,
                            PassionType.Dancing,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Coffee,
                            PassionType.Cars,
                            PassionType.Karoke,
                            PassionType.Outdoors,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Photography,
                            PassionType.Physics,
                            PassionType.Poetry,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Reading,
                            PassionType.Writer,
                            PassionType.CatLover,
                            PassionType.Bollywood,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Comedy,
                            PassionType.Art,
                            PassionType.Activism,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Singing,
                            PassionType.Programming,
                            PassionType.Coding
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Hunting,
                            PassionType.Hacking,
                            PassionType.Army,
                            PassionType.Skiing,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Youtube,
                            PassionType.God,
                            PassionType.Stars,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Voulenteering,
                            PassionType.Travel,
                            PassionType.Netflix,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Sneakers,
                            PassionType.Potterhead,
                            PassionType.Gardening,
                            PassionType.Books,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Hollywood,
                            PassionType.Avengers,
                            PassionType.OneDirection,
                          ],
                        ),
                        PassionRow(
                          passions: [
                            PassionType.Dark,
                            PassionType.Tea,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<PassionProvider>(
                  builder: (context, prov, _) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            gradient: (prov.passions.length >= 5)
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
                            color: Colors.grey[100]),
                        child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent)),
                          onPressed: (prov.passions.length >= 5)
                              ? () {
                                  if (prov.passions.length < 5) {
                                    return;
                                  }
                                  prov._service.user.passions = prov.passions;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PhotosScreen()));
                                }
                              : null,
                          child: Text(
                            "Continue (${prov.passions.length}/5)"
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
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

class PassionButton extends StatelessWidget {
  final PassionType passion;
  const PassionButton({Key key, this.passion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _passionProvider = Provider.of<PassionProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        height: 33,
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            border: (_passionProvider.passions?.contains(passion) ?? false)
                ? Border.all(color: Colors.red)
                : Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Colors.white),
        child: TextButton(
          onPressed: () {
            _passionProvider.toggle(passion);
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            elevation: MaterialStateProperty.all<double>(0),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(5),
            ),
          ),
          child: Text(
            PassionTypeToLabel(passion),
            style: TextStyle(
              fontSize: 15,
              color: (_passionProvider.passions?.contains(passion) ?? false)
                  ? Colors.red
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class PassionRow extends StatelessWidget {
  final List<PassionType> passions;
  const PassionRow({Key key, this.passions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i in passions)
              PassionButton(
                passion: i,
              )
          ],
        ),
      ),
    );
  }
}
