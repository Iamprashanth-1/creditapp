import 'package:flutter/material.dart';
import 'text_recognition_widget.dart';

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
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("push"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
              title: new Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.power, color: Color.fromARGB(255, 0, 0, 0)),
              title: new Text('Power'))
        ],
        onTap: (index) {
          if (index == 0) {
            onClickedPickImage();
          } else {}
          onClickedScanText();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          onClickedClear();
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
