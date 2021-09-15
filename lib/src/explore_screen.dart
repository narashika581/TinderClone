import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/data/explore_json.dart';
import 'package:tinder_clone/src/data/icons.dart';
import 'package:tinder_clone/src/models/passion_type.dart';
import 'package:tinder_clone/src/models/swipe_type.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/models/user_list_response.dart';
import 'package:tinder_clone/src/service.dart';

class ExploreProvider with ChangeNotifier {
  BuildContext ctxt;
  int index = 0;
  TinderService _service;
  int currentCard = 0;
  List<String> isLoginEnabled = [];
  ExploreProvider(BuildContext context) {
    this.ctxt = context;
    _service = Provider.of<TinderService>(context, listen: false);
  }

  void updateCurrentCard(int i) {
    currentCard = i;
    notifyListeners();
  }

  int getCurrentCard() {
    return currentCard;
  }
}

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  CardController controller;
  TinderService _service;
  List itemsTemp = [];
  int itemLength = 0;
  List<User> users;
  bool fetched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<User>> fetchUsers() async {
    _service = Provider.of<TinderService>(context);
    var resp = await _service.getUsers();
    if (resp.code == 200) {
      return resp.result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: getBody(),
      ),
    );
  }

  List<Uint8List> convertImgTobyte(List<User> users) {
    List<Uint8List> byties = [];
    for (var i = 0; i < users.length; i++) {
      byties.add(base64.decode(users[i].images[0]));
    }
    return byties;
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  Widget getBody() {
    var currentIndex = 0;
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: fetchUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                semanticsLabel: "Looking for Potential Matches",
                semanticsValue: "Looking for Potential Matches",
              ));
            default:
              if (snapshot.hasError)
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(100),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepOrange[300],
                          Colors.pink[300],
                          Colors.pink[400]
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      "Come back later !".toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              else
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    // height: size.height,
                    child: TinderSwapCard(
                      totalNum: snapshot.data.length + 1,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height,
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: MediaQuery.of(context).size.height * 0.99,
                      cardBuilder: (context, index) {
                        print(index);
                        if (index == snapshot.data.length) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(100),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepOrange[300],
                                    Colors.pink[300],
                                    Colors.pink[400]
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Text(
                                "Come back later !".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 2),
                                    ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: size.width,
                                        height: size.height,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(
                                                  snapshot.data[index].dp),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      // Selector<ExploreProvider,SwipeType>(
                                      //   selector: (buildContext , prov)=>prov.,
                                      //   Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Container(
                                      //     decoration: BoxDecoration(
                                      //       border: Border.all(
                                      //           color: Colors.red, width: 5),
                                      //     ),
                                      //     child: Padding(
                                      //         padding: const EdgeInsets.all(8.0),
                                      //         child: GradientText("LIKE",
                                      //             gradient: LinearGradient(
                                      //                 begin: Alignment.topRight,
                                      //                 end: Alignment.bottomLeft,
                                      //                 colors: [
                                      //                   Colors.deepOrange[300],
                                      //                   Colors.pink[300],
                                      //                   Colors.pink[400]
                                      //                 ]))),
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Align(
                                      //     alignment: Alignment.topRight,
                                      //     child: Container(
                                      //       decoration: BoxDecoration(
                                      //         border: Border.all(
                                      //             color: Colors.red, width: 5),
                                      //       ),
                                      //       child: Padding(
                                      //           padding: const EdgeInsets.all(8.0),
                                      //           child: GradientText("UNLIKE",
                                      //               gradient: LinearGradient(
                                      //                   begin: Alignment.topRight,
                                      //                   end: Alignment.bottomLeft,
                                      //                   colors: [
                                      //                     Colors.deepOrange[300],
                                      //                     Colors.pink[300],
                                      //                     Colors.pink[400]
                                      //                   ]))),
                                      //     ),
                                      //   ),
                                      // ),
                                      // )
                                      Container(
                                        width: size.width,
                                        height: size.height,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                              Colors.black.withOpacity(0.25),
                                              Colors.black.withOpacity(0),
                                            ],
                                                end: Alignment.topCenter,
                                                begin: Alignment.bottomCenter)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.72,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .age
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 10,
                                                              height: 10,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Last Active " +
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .active,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: List.generate(
                                                                snapshot
                                                                    .data[index]
                                                                    .passions
                                                                    .length,
                                                                (indexLikes) {
                                                              if (indexLikes ==
                                                                  0) {
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 8),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .white,
                                                                            width:
                                                                                2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.4)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              3,
                                                                          bottom:
                                                                              3,
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        PassionTypeToLabel(snapshot
                                                                            .data[index]
                                                                            .passions[indexLikes]),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.2)),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 3,
                                                                        bottom:
                                                                            3,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: Text(
                                                                      PassionTypeToLabel(snapshot
                                                                          .data[
                                                                              index]
                                                                          .passions[indexLikes]),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.info,
                                                          color: Colors.white,
                                                          size: 28,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width,
                              height: 120,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () => controller.triggerLeft(),
                                        child: Container(
                                          width: 58.0,
                                          height: 58.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 10,
                                                  // changes position of shadow
                                                ),
                                              ]),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/img/close_icon.svg',
                                              width: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller.triggerRight(),
                                        child: Container(
                                          width: 57.0,
                                          height: 57.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 10,
                                                  // changes position of shadow
                                                ),
                                              ]),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/img/like_icon.svg',
                                              width: 27,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        );
                      },
                      cardController: controller = CardController(),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        if (align.x < -10) {
                        } else if (align.x > 10) {}
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        /// Get orientation & index of swiped card!
                        print(snapshot.data[index].name);
                        if (orientation == CardSwipeOrientation.RIGHT) {
                          print("right swiped");
                          _service.swipe(
                              SwipeType.LIKE, snapshot.data[index].id);
                        }
                        if (orientation == CardSwipeOrientation.LEFT) {
                          print("left swiped");
                          _service.swipe(
                              SwipeType.UNLIKE, snapshot.data[index].id);
                        }
                        if (index == (snapshot.data.length - 1)) {
                          print("all done bhaiya");
                          // setState(() {
                          //   print(itemLength);
                          //   print(itemsTemp);
                          //   itemLength = itemsTemp.length - 1;
                          // });
                        }
                      },
                    ),
                  ),
                );
          }
        });
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }
}
