import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:clipboard/clipboard.dart';
import 'package:tvscred/api/firebase_ml_api.dart';
import 'package:tvscred/widget/text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'package:flutter/scheduler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:status_alert/status_alert.dart';

//import 'package:cool_alert/cool_alert.dart';

import 'package:camera/camera.dart';

import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;
  // Map<String, String> jas={};

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 168),
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
            : Icon(Icons.photo, size: 40, color: Colors.black),
      );

  Future showSelectionDial() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
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

  Future pickImage() async {
    final fil = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(fil.path));
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future cam() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file.path));
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 1.0,
      //ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
  }

  Future scanTe() {
    showDialog(
      context: context,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
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

      print('sai kart');

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

  Future scanTexts(String tex) async {
    //final String tex = '';
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
                builder: (context) =>
                    MainPage(title: "TVS KYC and Registration"))
            //SignInDemo()
            //  Dash()
            );
        Navigator.of(context, rootNavigator: true).pop();
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

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "FLAT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void scans() async {
    final String apiUrl = "https://damp-river-68332.herokuapp.com/license";

    final responses = await http.post(apiUrl, body: jas);
    print(responses.body);
    print(responses.statusCode);
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
