import 'package:flutter/material.dart';
import '.././main.dart';
import '../registration/text_recor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../blue.dart';
import '../splashs.dart';

//void main() => runApp(MyApp());
final List<String> imgList = [
  'https://www.tvsmotor.com/-/media/Feature/Our-Stories/2020-TVS-Apache-RR-310-BS6-D.png?h=786&w=436&la=en&hash=2000C3FD696B2C5CB3D54C37E9AE73FC',
  'https://www.tvsmotor.com/-/media/Feature/Our-Stories/Ntorq-Graphic-Novel-D.jpg?h=786&w=436&la=en&hash=F491593B614BD564204B107C4238CA3E',
  'https://www.tvsmotor.com/-/media/Feature/Our-Stories/TVS-iQube-EV-D.png?h=786&w=436&la=en&hash=B0E03ADDF7A72200D7209DFA33BBEF7F',
  'https://www.tvsmotor.com/-/media/Feature/About-US/racing-hero.jpg',
  'https://www.tvsmotor.com/-/media/Feature/About-US/35-Million.png?h=261&w=434&la=en&hash=3DF006B1F0FC78236ABBC0CF1A2E9855',
  'https://www.tvsmotor.com/-/media/Feature/About-US/vehicle-for-everyone-2.jpg?h=261&w=434&la=en&hash=DE4F7BED3DCC640B3D6933EC2503F23E'
];

/// This is the main application widget.
///
class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Stack(children: <Widget>[
      Image.asset(
        "assets/images/race.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    ]);

    return Scaffold(
      //backgroundColor: Colors.blue,
      // backgroundColor: Colors.transparent,
      body: Column(children: [
        CarouselSlider(
          items: imgList
              .map((item) => Container(
                    child: Center(
                        child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 2000,
                    )),
                  ))
              .toList(),
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              height: 250,
              aspectRatio: 6.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //print(_selectedIndex);
    if (_selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(title: "KYC Verification")));
    } else if (_selectedIndex == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Registration(title: "Registration Page")));
    } else if (_selectedIndex == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Stack(children: <Widget>[
      Image.asset(
        "assets/images/race.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('TVS KYC and Vehicle status check'),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      // body: Center(
      //  child: _widgetOptions.elementAt(_selectedIndex),
      //),
      body: CarouselWithIndicatorDemo(),

      bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'KYC',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Registration',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth_audio),
              label: 'OBD',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          backgroundColor: Colors.blue,
          onTap: _onItemTapped,
          iconSize: 40,
          elevation: 5),
    );
  }
}

//

class Registration extends StatefulWidget {
  final String title;
  

  const Registration({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<Registration> {
  get theme => null;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          toolbarHeight:60,

          
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextRecognitionWidgetr(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}
