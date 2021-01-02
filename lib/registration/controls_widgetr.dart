import 'package:flutter/material.dart';
import "./text_recor.dart";
import 'package:draggable_floating_button/draggable_floating_button.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 0.1),
          RaisedButton(
            onPressed: onClickedPickImage,
            child: Text('Pick Image'),
            //splashColor: Colors.grey,
            color: Color(0xFF083386),
            textColor: Colors.white,

            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          const SizedBox(height: 30, width: 1),
          RaisedButton(
            onPressed: onClickedScanText,
            child: Text('Scan image'),
            color: Color(0xFF083386),
            textColor: Colors.white,
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.clear),
            label: Text("Clear"),
            onPressed: () {
              gg(context);
              onClickedClear();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          )
        ],
      );
}

void gg(BuildContext context) {
  final snackBar = SnackBar(content: Text('Yay! You have cleared!'));
  Scaffold.of(context).showSnackBar(snackBar);
}
