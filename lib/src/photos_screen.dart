import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/src/date_screen.dart';
import 'package:tinder_clone/src/home_root_screen.dart';
import 'package:tinder_clone/src/home_root_screen.dart';
import 'package:tinder_clone/src/models/status_response.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/service.dart';
import 'package:video_player/video_player.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageProvider with ChangeNotifier {
  BuildContext ctxt;
  int index = 0;
  Map<int, PickedFile> images = {};
  TinderService _service;
  List<String> isLoginEnabled = [];
  ImageProvider(BuildContext context) {
    this.ctxt = context;
    _service = Provider.of<TinderService>(context, listen: false);
  }

  int getIndex() {
    print("called");
    index++;
    return index - 1;
  }

  int getLength() {
    if (images == null) {
      return 0;
    } else {
      var len = 0;
      if (images.length == 0) {
        return len;
      }

      images.forEach((key, value) {
        if (value != null) {
          len++;
          print(value.path);
        }
      });
      return len;
    }
  }

  void removeKey(int id) {
    images.remove(id);
    print("removed");
    print(images.length);
    notifyListeners();
  }

  operator []=(key, value) {
    images[key] = value;
    notifyListeners();
  }

  void register(BuildContext context) async {
    List<String> finalImages = [];
    images.forEach((key, value) async {
      var img = Image.file(File(value.path));
      var temp = File(value.path).readAsBytesSync();
      finalImages.add(base64Encode(temp));
    });
    print(finalImages[0]);
    _service.user.images = finalImages;
    StatusResponse resp = await _service.registerComplete(_service.user);
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

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreenRoot()),
        (Route<dynamic> route) => false);
    // _service.user.images
  }
}

class PhotosScreen extends StatefulWidget {
  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  TextEditingController controllerFName;
  bool _isButtonActives;

  void initState() {
    super.initState();
    controllerFName = TextEditingController();
    _isButtonActives = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageProvider(context),
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Photos",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 40),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 30),
                    child: Text(
                      "Add atleast 2 photos to continue.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    ImageRowCont(
                      row: 1,
                    ),
                    ImageRowCont(
                      row: 2,
                    ),
                  ],
                )),
                Consumer<ImageProvider>(
                  builder: (context, prov, _) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            gradient: (prov.getLength() >= 2)
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
                          onPressed: (prov.getLength() >= 2)
                              ? () {
                                  print("ho gaya ggg");
                                  prov.register(context);
                                }
                              : null,
                          child: Text(
                            "Done".toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
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

class ImageRowCont extends StatelessWidget {
  final int row;

  const ImageRowCont({Key key, this.row}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _passionProvider = Provider.of<ImageProvider>(context);
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ImageCont(id: 1 * row),
          fit: FlexFit.tight,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: ImageCont(id: 2 * row),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: ImageCont(id: 3 * row),
        )
      ],
    );
  }
}

class ImageCont extends StatefulWidget {
  final int id;

  const ImageCont({Key key, this.id}) : super(key: key);
  @override
  _ImageContState createState() => _ImageContState();
}

class _ImageContState extends State<ImageCont> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  String _retrieveDataError;
  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (false) {
      } else {
        return Semantics(
            child: Image.file(
              File(_imageFile.path),
              fit: BoxFit.fill,
            ),
            image: true,
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData(ImageProvider src) async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (false) {
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
          print("start");
          src.images[widget.id] = _imageFile;
          print(_imageFile.path);
          print("end");
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  final ImagePicker _picker = ImagePicker();
  Future<ImageSource> _displayPickImageDialog(
      BuildContext context, ImageProvider prov) async {
    ImageSource src;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Choose one of the option'),
            content: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("camera"),
                    leading: Icon(Icons.camera),
                    onTap: () {
                      src = ImageSource.camera;
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text("Image from gallery"),
                    leading: Icon(Icons.album),
                    onTap: () {
                      src = ImageSource.gallery;
                      Navigator.of(context).pop();
                    },
                  ),
                  if (_imageFile != null)
                    ListTile(
                      title: Text("Remove image"),
                      leading: Icon(Icons.remove_circle),
                      onTap: () {
                        src = null;
                        setState(() {
                          _imageFile = null;
                          prov.removeKey(widget.id);
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    return src;
  }

  @override
  Widget build(BuildContext context) {
    var _imageProvider = Provider.of<ImageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          DottedBorder(
            color: (_imageFile == null) ? Colors.grey : Colors.red,
            strokeWidth: (_imageFile == null) ? 1 : 1.8,
            borderType: BorderType.RRect,
            radius: Radius.circular(10),
            dashPattern: [8, 4],
            strokeCap: StrokeCap.round,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[100],
              ),
              child: FutureBuilder(
                future: retrieveLostData(_imageProvider),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Text("");
                    case ConnectionState.done:
                      return _previewImage();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              ),
            ),
          ),
          Container(
            height: 200,
            child: Align(
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.add_circle),
                tooltip: widget.id.toString(),
                color: Colors.red,
                onPressed: () async {
                  ImageSource src =
                      await _displayPickImageDialog(context, _imageProvider);
                  print(src);
                  if (src == null) {
                    return;
                  }
                  print("asdasda");

                  try {
                    final pickedFile = await _picker.getImage(
                      source: src,
                      // maxWidth: maxWidth,
                      // maxHeight: maxHeight,
                      // imageQuality: quality,
                    );
                    setState(() {
                      _imageFile = pickedFile;
                      _imageProvider[widget.id] = pickedFile;
                      print("added");
                    });
                  } catch (e) {
                    setState(() {
                      _pickImageError = e;
                    });
                  }
                },
              ),
              alignment: Alignment.bottomRight,
            ),
          )
        ],
      ),
    );
  }
}
