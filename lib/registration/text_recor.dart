import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:tvscred/api/firebase_ml_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merge_images/merge_images.dart';
import 'package:status_alert/status_alert.dart';
import '../widget/dash.dart';

//import 'package:cool_alert/cool_alert.dart';

//import 'package:camera/camera.dart';

import 'controls_widgetr.dart';
import 'dart:ui' as ui;

class TextRecognitionWidgetr extends StatefulWidget {
  const TextRecognitionWidgetr({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidgetr> {
  String text = '';
  File image;

  // Map<String, String> jas={};

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 10),
            ControlsWidget(
              onClickedPickImage: showSelectionDial,
              onClickedScanText: scanText,
              onClickedClear: () {
                clear(context);
              },
              //onClickedcam: cam,
            ),
          ],
        ),
      );

  Widget buildImage() => Container(
        child: image != null
            ? Image.file(image)
            : Icon(Icons.photo, size: 80, color: Colors.black),
      );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    final file1 = await ImagePicker().getImage(source: ImageSource.gallery);

    ui.Image image1 =
        await ImagesMergeHelper.loadImageFromFile(File(file.path));
    ui.Image image2 =
        await ImagesMergeHelper.loadImageFromFile(File(file1.path));

    ui.Image image = await ImagesMergeHelper.margeImages([image1, image2],

        ///required,images list
        fit: true,

        ///scale image to fit others
        direction: Axis.vertical,

        ///direction of images
        backgroundColor: Colors.black26);
    File file3 = await ImagesMergeHelper.imageToFile(image);
    //print(file);
    setImage(file3);
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future showSelectionDial() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Take Image From "),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        pickImage();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        cam();
                      },
                    )
                  ],
                ),
              ));
        });
  }

  Future cam() async {
    final file3 = await ImagePicker().getImage(source: ImageSource.camera);
    ui.Image image3 =
        await ImagesMergeHelper.loadImageFromFile(File(file3.path));
    final file4 = await ImagePicker().getImage(source: ImageSource.camera);
    ui.Image image4 =
        await ImagesMergeHelper.loadImageFromFile(File(file4.path));

    ui.Image image0 = await ImagesMergeHelper.margeImages([image3, image4],

        ///required,images list
        fit: true,

        ///scale image to fit others
        direction: Axis.vertical,

        ///direction of images
        backgroundColor: Colors.black26);
    File file5 = await ImagesMergeHelper.imageToFile(image0);
    setImage(file5);
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future scanText() async {
    showDialog(
      context: context,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    //var client = new http.Client();
    if (image == null) {
      dfkk('Please select image');
      Navigator.of(context, rootNavigator: true).pop('dialog');
    } else {
      final text = await FirebaseMLApi.recogniseText(image);
      setText(text);

      //_onAlertButtonsPressed(context);
      // scanTexts(text);
      showAlertDialog(context, text);

      //var res=await client.get('https://9748e5dd28d6.ngrok.io');
      //print(res.body);

      // Navigator.of(context).pop();
    }
  }

  void dfkk(String sss) {
    StatusAlert.show(context,
        duration: Duration(seconds: 2),
        title: sss,
        configuration: IconConfiguration(icon: Icons.error));
  }

  void scans() async {
    final String apiUrl = "https://damp-river-68332.herokuapp.com/license";

    final responses = await http.post(apiUrl, body: jas);
    // print(responses.body);
    //print(responses.statusCode);
    print('nice');

    if (responses.statusCode == 200) {
      //showAlertDialog(context);
      dfss(" Verification Success");
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      dfs("failed");
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void dfs(String sss) {
    StatusAlert.show(context,
        duration: Duration(seconds: 2),
        title: sss,
        configuration: IconConfiguration(icon: Icons.error_outline));
  }

  void dfss(String sss) {
    StatusAlert.show(context,
        duration: Duration(seconds: 2),
        title: sss,
        configuration: IconConfiguration(icon: Icons.done));
  }

  Future scanTexts(String tex) async {
    showDialog(
      context: context,
      child: Center(
        child: Text(tex),
      ),
    );
  }

  showAlertDialog(BuildContext context, String tex) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        //scans();
        //SchedulerBinding.instance.addPostFrameCallback((_) {
        scans();

        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget rescan = FlatButton(
      child: Text("rescan"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Registration(title: "Registration")));
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Please verify your details"),
      content: Text(tex),
      actions: [
        okButton,
        rescan,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void df(String ss) {
    Fluttertoast.showToast(
      msg: ss,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  void gg(BuildContext context) {
    final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void clear(BuildContext context) {
    onPressed:
    () {
      gg;
    };
    setImage(null);
    setText('');
    gg(context);
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  Map<String, String> jas = {};
  void setText(String newText) {
    setState(() {
      text = newText;
    });
    //Map<String, String> jas={};
    List<String> ad = newText.split('\n');
    List<String> kk = [
      'Type',
      'state',
      'regNo',
      'Name',
      'FName',
      'H-no',
      'Street',
      'Mdl',
      "mdl"
    ];
    for (var i = 0; i < 5; i++) {
      jas[kk[i]] = ad[i].replaceAll(' ', '');
    }
    print(jas);
  }
}

class MyAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RaisedButton(
        child: Text('Show alert'),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Simple Alert"),
    content: Text("This is an alert message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
