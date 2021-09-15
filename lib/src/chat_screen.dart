import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/home_root_screen.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/private_chatscreen.dart';
import 'package:tinder_clone/src/service.dart';

class ChatScreenProvider extends ChangeNotifier {
  BuildContext ctxt;
  int PrevLength;
  TinderService service;
  RecentProvider rootService;
  Timer stopper;
  List<User> users = [];
  ChatScreenProvider(this.ctxt) {
    service = Provider.of<TinderService>(ctxt, listen: false);
    fetchData();
    rootService = Provider.of<RecentProvider>(ctxt, listen: false);
    stopper = Timer.periodic(Duration(seconds: 5), (z) async {
      var currentLength = users.length;
      print("current length ${currentLength}");
      await fetchData();
      if (users.length != currentLength) {
        rootService.updateChats(1, users.length - currentLength);
      }
      notifyListeners();
    });
  }
  void dispose() {
    super.dispose();
    stopper.cancel();
  }

  Future<int> fetchData() async {
    var res = (await service.listMatches());
    if (res.code == 200) {
      users = res.result;
      print("fetching matches got ${users.length}");

      notifyListeners();
      return users.length;
    } else {}
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatScreenProvider(context),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ChatScreenProvider>(
          builder: (context, provider, __) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.pink[400].withOpacity(0.7),
                                Colors.pink[300].withOpacity(0.7),
                                Colors.deepOrange[300].withOpacity(0.7),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                          child: ListTile(
                            // tileColor: Colors.grey,
                            subtitle: Text("No new messages"),
                            title: Text(
                              provider.users[index].name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => PrivateChat(
                                          messaging: provider.users[index],
                                        ))),
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(provider.users[index].dp),
                              radius: 30,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
