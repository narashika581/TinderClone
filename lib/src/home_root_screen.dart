import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/main.dart';
import 'package:tinder_clone/src/account_screen.dart';
import 'package:tinder_clone/src/chat_screen.dart';
import 'package:tinder_clone/src/explore_screen.dart';
import 'package:tinder_clone/src/likes_screen.dart';
import 'package:tinder_clone/src/service.dart';

class RecentProvider extends ChangeNotifier {
  BuildContext ctxt;
  List<int> chats = [0, 0, 0];
  RecentProvider(this.ctxt);

  int getChats(int s) {
    return chats[s];
  }

  void updateChats(int i, int num) {
    chats[i] = num;
    notifyListeners();
  }
}

class HomeScreenRoot extends StatefulWidget {
  @override
  _HomeScreenRootState createState() => _HomeScreenRootState();
}

class _HomeScreenRootState extends State<HomeScreenRoot> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecentProvider(context),
      builder: (context, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: getAppBar(),
          body: getBody(),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [ExplorePage(), ChatPage(), AccountPage()],
    );
  }

  Widget getAppBar() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/img/explore_active_icon.svg"
          : "assets/img/explore_icon.svg",
      pageIndex == 1
          ? "assets/img/chat_active_icon.svg"
          : "assets/img/chat_icon.svg",
      pageIndex == 2
          ? "assets/img/account_active_icon.svg"
          : "assets/img/account_icon.svg",
    ];
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Consumer<RecentProvider>(builder: (context, provider, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomItems.length, (index) {
                return Stack(
                  children: [
                    if (provider.getChats(index) != 0)
                      Container(
                        // margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            border: Border.all(
                              color: Colors.red[500],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          provider.getChats(index).toString(),
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        provider.updateChats(index, 0);
                        setState(() {
                          pageIndex = index;
                        });
                      },
                      icon: SvgPicture.asset(
                        bottomItems[index],
                      ),
                    ),
                  ],
                );
              }),
            );
          })),
    );
  }
}
