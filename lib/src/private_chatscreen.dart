import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/models/message.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';

class PrivateChatProvider extends ChangeNotifier {
  BuildContext ctxt;
  TinderService service;
  List<Message> messages = [];
  int lastCount = 0;
  User to;
  Timer stopper;
  PrivateChatProvider(this.ctxt, this.to) {
    service = Provider.of<TinderService>(ctxt, listen: false);
    fetchMessages();
    stopper = Timer.periodic(Duration(seconds: 2), (timer) => fetchMessages());
  }
  void dispose() {
    super.dispose();
    stopper.cancel();
  }

  void fetchMessages() async {
    print("fetching messages");
    var resp = await service.getMessages(to.id);
    if (resp.code == 200) {
      resp.result ??= [];
      if (resp.result.length == lastCount) {
        return;
      }
      print("rebuilding");
      messages = resp.result;
      lastCount = messages.length;
      notifyListeners();
    }
  }

  void submit(String s, BuildContext context) async {
    if (s.trim() == '') {
      return;
    }
    Message m = Message()
      ..message = s
      ..to = to.id;
    print("message ; " + s);
    var resp = await service.sendMessage(m);
    if (resp.code == 200) {
      fetchMessages();
    } else {}
  }
}

class PrivateChat extends StatefulWidget {
  final User messaging;
  const PrivateChat({Key key, this.messaging}) : super(key: key);
  @override
  _PrivateChatState createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  ScrollController scrollController;
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ChangeNotifierProvider(
          create: (context) => PrivateChatProvider(context, widget.messaging),
          builder: (context, child) => Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  backgroundColor: Colors.grey[50],
                  title: Text(
                    widget.messaging.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                body: Consumer<PrivateChatProvider>(
                    builder: (context, provider, __) {
                  return Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                  children: (provider.messages.length != 0)
                                      ? List.generate(provider.messages.length,
                                          (index) {
                                          var scrollPosition =
                                              scrollController.position;

                                          scrollController.animateTo(
                                            scrollPosition.maxScrollExtent,
                                            duration:
                                                new Duration(milliseconds: 200),
                                            curve: Curves.easeOut,
                                          );
                                          return (provider.messages[index].to ==
                                                  provider.service.user.id)
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.pink[400]
                                                              .withOpacity(0.7),
                                                          Colors.pink[300]
                                                              .withOpacity(0.7),
                                                          Colors.deepOrange[300]
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider
                                                              .messages[index]
                                                              .message,
                                                          style: TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                              readTimestamp(
                                                                  provider
                                                                      .messages[
                                                                          index]
                                                                      .epochTime)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      15)),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.pink[400]
                                                              .withOpacity(0.7),
                                                          Colors.pink[300]
                                                              .withOpacity(0.7),
                                                          Colors.deepOrange[300]
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          provider
                                                              .messages[index]
                                                              .message,
                                                          style: TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                              readTimestamp(
                                                                  provider
                                                                      .messages[
                                                                          index]
                                                                      .epochTime)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                        })
                                      : [
                                          Container(
                                            child: Text("no messages"),
                                          )
                                        ]),
                            ),
                          ),
                        ),
                        TextField(
                          onTap: () {
                            var scrollPosition = scrollController.position;
                            print(scrollPosition.maxScrollExtent);
                            scrollController.animateTo(
                              scrollPosition.maxScrollExtent,
                              duration: new Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                            );
                          },
                          controller: this.controller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.message),
                              labelText: "Type ur message",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  provider.submit(controller.text, context);
                                  controller.clear();
                                },
                                tooltip: "Fire Message",
                                splashColor: Colors.red,
                              )),
                        ),
                      ],
                    ),
                  );
                }),
              )),
    );
  }
}

// class TextInputWidget extends StatefulWidget {
//   final Function(String, BuildContext) submit;
//   const TextInputWidget({Key key, this.submit}) : super(key: key);
//   @override
//   _TextInputWidgetState createState() => _TextInputWidgetState();
// }

// class _TextInputWidgetState extends State<TextInputWidget> {

//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
