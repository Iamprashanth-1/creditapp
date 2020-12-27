import 'package:flutter/material.dart';
import "./text_recognition_widget.dart";

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;
  final VoidCallback onClickedcam;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    @required this.onClickedcam,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 0.1),
          RaisedButton(
            onPressed: onClickedPickImage,
            child: Text('Pick Image'),
          ),
          const SizedBox(height: 30,width: 1),
          RaisedButton(
            onPressed: onClickedScanText,
            child: Text('Upload'),
          ),
          const SizedBox(width: 0.1),
          RaisedButton(
            onPressed: onClickedcam,
            child: Text('Camera'),
          ),
          const SizedBox(width: 1),
          RaisedButton(
            onPressed: (){
          
            gg(context);
            onClickedClear();},
              
            child: Text('Clear'),
            
          )
        ],
      );
}
void gg(BuildContext context){

    final snackBar = SnackBar(

            content: Text('Yay! You have cleared!'));
    Scaffold.of(context).showSnackBar(snackBar);


  }
