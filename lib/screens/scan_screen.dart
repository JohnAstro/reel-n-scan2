import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:reel_n_scan/config/globals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:reel_n_scan/screens/fish_info_screen.dart';
import 'package:reel_n_scan/database/fish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reel_n_scan/screens/newlog_screenn.dart';
import 'package:tflite/tflite.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  List? _listResult;
  XFile? _imageFile;
  bool _loading = false;
  List _allResults = [];
  List _resultsList = [];
  late Future resultsLoaded;
  late var predictedFish;

  // Toggle button selector
  List<bool> isSelected = List.generate(1, (index) => false);

  @override
  void initState() {
    super.initState();
    _loading = true;
    _loadModel().then((value) {});
    getFishes();
  }

  _loadModel() async {
    await Tflite.loadModel(
      model: "assets/modelv3.tflite",
      labels: "assets/labels.txt",
    ).then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  // Used to create local file directory of asset image in the device
  // Called in integration test only
  // https://stackoverflow.com/questions/52353764/how-do-i-get-the-assets-file-path-in-flutter
  Future<File> getImageFileFromAssets(String path, int num) async {
    final byteData = await rootBundle.load('assets/$path');
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/file_0$num.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  void _pickImage(imageSource) async {
    File? imageFile;

    // Check if not in integration test
    if (!areWeInIntegrationTest) {
      var image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return null;
      imageFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 390,
          maxWidth: 390,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Color(0xff4C748B),
              toolbarTitle: "Fish Cropper",
              statusBarColor: Colors.blueGrey.shade900,
              backgroundColor: Color(0xff4C748B)));
    } else {
      if (imageSource == ImageSource.camera) {
        imageFile = await getImageFileFromAssets('fish_images/Bass.png', 1);
      } else if (imageSource == ImageSource.gallery) {
        imageFile =
            await getImageFileFromAssets('fish_images/Pufferfish.png', 2);
      }
    }
    setState(() {
      _loading = true;
      _imageFile = XFile(imageFile!.path);
    });
    _predictImage(XFile(imageFile!.path));
    getFishes();
  }

  void _gallery() async {
    _pickImage(ImageSource.gallery);
    // Done loading image after _pickImage
    setState(() {
      _loading = false;
    });
  }

  void _camera() async {
    _pickImage(ImageSource.camera);
    // Done loading image after _pickImage
    setState(() {
      _loading = false;
    });
  }

  void _predictImage(XFile? image) async {
    var output = await Tflite.runModelOnImage(
      path: image!.path,
      numResults: 10,
      threshold: 0.001,
      //https://www.tensorflow.org/lite/api_docs/python/tflite_model_maker/image_classifier/ModelSpec
      imageMean: 0,
      imageStd: 255,
    );
    setState(() {
      _loading = false;
      _listResult = output;
      //print(_listResult);
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  getFishes() async {
    var fishes = await FirebaseFirestore.instance
        .collection('fishes')
        .orderBy('name')
        .get();
    setState(() {
      _allResults = fishes.docs;
    });
  }

  searchResultsList() {
    var showResults = [];
    for (var fishSnapshot in _allResults) {
      var title = Fish.fromSnapshot(fishSnapshot).name.toLowerCase();
      String fishName = _listResult![0]['label'];
      fishName.toLowerCase();

      if (title == fishName) {
        showResults.add(fishSnapshot);
      }
    }
    setState(() {
      _resultsList = showResults;
      predictedFish = Fish.fromSnapshot(_resultsList[0]);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan',
          key: Key('scan-title'),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4C748B),
        leading: IconButton(
            key: Key('scan-back-button'),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 470,
          height: 470,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              height: 385,
              width: 385,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: _imageFile != null
                        ? Image.file(
                            File(_imageFile!.path),
                          )
                        : Placeholder(
                            fallbackHeight: 390,
                          ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: _listResult != null
                              ? Text(
                                  "It's a ${_listResult![0]['label']}!",
                                  key: Key('scan-result-text'),
                                  style: TextStyle(fontSize: 20),
                                )
                              : Text(
                                  "Upload Fish",
                                  style: TextStyle(fontSize: 20),
                                ),
                          subtitle: _listResult != null
                              ? Text(
                                  "${(_listResult![0]['confidence'] * 100).toStringAsFixed(1)}% confident")
                              : Text(""),
                        ),
                      ),
                      if (_listResult != null)
                        PopupMenuButton(
                          key: Key('options-button'),
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                key: Key('log-fish-option-button'),
                                child: Text('Log Fish'),
                                value: 0,
                              ),
                              PopupMenuItem(
                                key: Key('fish-info-option-button'),
                                child: Text('Fish Info'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: PopupMenuDivider(),
                                height: 1,
                              ),
                              PopupMenuItem(
                                child: Text('Wrong Fish?'),
                                value: 2,
                              ),
                            ];
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          offset: Offset.fromDirection(3 * 3.14 / 2, 160.0) +
                              Offset.fromDirection(3.14, 20),
                          onSelected: (result) {
                            setState(() {
                              if (result == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                            _listResult![0]['label'])));
                              }
                              if (result == 1) {
                                searchResultsList();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FishInfo(
                                              fish: predictedFish,
                                            )));
                              }
                            });
                          },
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('camera-button'),
        onPressed: _camera,
        backgroundColor: Color(0xff4C748B),
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 300),
              child: IconButton(
                key: Key('gallery-button'),
                icon: Icon(Icons.add_photo_alternate),
                color: Color(0xff4C748B),
                onPressed: _gallery,
                iconSize: 35,
              ),
            ),
          )),
    );
  }
}
