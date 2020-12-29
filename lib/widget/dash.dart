import 'package:flutter/material.dart';
import '.././main.dart';
//void main() => runApp(MyApp());

/// This is the main application widget.
class Dash extends StatelessWidget {
  static const String _title = 'TvsCREdit';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Welcome To TvsCREdit',
      style: optionStyle,
    ),
    Text(
      'You are done with KYC',
      style: optionStyle,
    ),
    Text(
      'You completed Registration',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //print(_selectedIndex);
    if (_selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(title: "Text Recognization")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TVS KYC and Vehicle status check'),
        centerTitle: true,
      ),
      // body: Center(
      //  child: _widgetOptions.elementAt(_selectedIndex),
      //),
      body: Center(
          child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://www.tvsmotor.com/-/media/Feature/Our-Stories/Ntorq-Graphic-Novel-D.jpg?h=786&w=436&la=en&hash=F491593B614BD564204B107C4238CA3E"),
                fit: BoxFit.cover)),
      )),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'KYC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Registration',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
