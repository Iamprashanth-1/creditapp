import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:tvscred/api/firebase_ml_api.dart';
import 'package:tvscred/widget/text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:cool_alert/cool_alert.dart';

//import 'package:camera/camera.dart';

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
            const SizedBox(height: 16),
            ControlsWidget(
              onClickedPickImage: pickImage,
              onClickedScanText: scanText,
              onClickedClear:(){clear(context);},
              onClickedcam: cam,
            ),
            const SizedBox(height: 16),
            TextAreaWidget(
              text: text,
              onClickedCopy: copyToClipboard,
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
    setImage(File(file.path));
  }
  Future cam() async {
    final files = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(files.path));
  }
  
  

  Future scanText() async {
    showDialog(
      context: context,
      child: Center(
        child: CircularProgressIndicator(),
      ),

    );
    //var client = new http.Client(); 
  
    

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);
    print('sai kart');
    //var res=await client.get('https://9748e5dd28d6.ngrok.io'); 
    //print(res.body);
    final String apiUrl = "https://damp-river-68332.herokuapp.com/license";

    final responses = await http.post(apiUrl, body: jas);
    print(responses.body);
    print(responses.statusCode);
    if(responses.statusCode == 200){
      //showAlertDialog(context);
      df(" Verification Success");
    }
    else{
      df("failed");
    }
    


    Navigator.of(context).pop();
  }

  void df(String ss){
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
  void gg(BuildContext context){

    final snackBar = SnackBar(

            content: Text('Yay! A SnackBar!'));
    Scaffold.of(context).showSnackBar(snackBar);


  }

  void clear(BuildContext context) {
    onPressed: () {gg;};
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
  Map<String, String> jas={};
  void setText(String newText) {
    setState(() {
      text = newText;
    });
    //Map<String, String> jas={};
    List<String> ad =newText.split('\n');
    List<String> kk=['Type','state','regNo','Name','FName','H-no','Street','Mdl',"mdl"];
    for(var i=0 ;i<5;i++){
      jas[kk[i]]=ad[i].replaceAll(' ', '');
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