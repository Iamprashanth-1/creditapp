import 'package:flutter/material.dart';
import '.././main.dart';
import '../registration/text_recor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../splashs.dart';
import '../log.dart';
// import 'package:webview_flutter/webview_flutter.dart';

//void main() => runApp(MyApp());
final List<String> imgList = [
  'https://www.tvsmotor.com/-/media/Feature/Our-Stories/2020-TVS-Apache-RR-310-BS6-D.png?h=786&w=436&la=en&hash=2000C3FD696B2C5CB3D54C37E9AE73FC',
  'https://www.tvsmotor.com/-/media/Feature/Our-Stories/Ntorq-Graphic-Novel-D.jpg?h=786&w=436&la=en&hash=F491593B614BD564204B107C4238CA3E',
  'https://www.tvsmotor.com/-/media/Feature/Our-Stories/TVS-iQube-EV-D.png?h=786&w=436&la=en&hash=B0E03ADDF7A72200D7209DFA33BBEF7F',
  'https://www.tvsmotor.com/-/media/Feature/About-US/racing-hero.jpg',
  'https://www.tvsmotor.com/-/media/Feature/About-US/35-Million.png?h=261&w=434&la=en&hash=3DF006B1F0FC78236ABBC0CF1A2E9855',
  'https://www.tvsmotor.com/-/media/Feature/About-US/vehicle-for-everyone-2.jpg?h=261&w=434&la=en&hash=DE4F7BED3DCC640B3D6933EC2503F23E',
  'https://www.tvsmotor.com/-/media/Feature/Vehicles/vehicles/Homepage/Desktop/TVS_XL_2020.jpg?h=484&w=890&la=en&hash=C1E937552A12950B825982D3A403A477'
];

class News {
  String title;
  String content;
  String description;
  String path;
  String imagePath;
  String publishedAt;
  String sourceName;
  String sourceId;

  News(
      {this.title,
      this.content,
      this.description,
      this.path,
      this.imagePath,
      this.publishedAt,
      this.sourceName,
      this.sourceId});

  // News.empty();
}

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
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  List<News> news = [
    new News(
        title: 'Benefits of Biking',
        content: '10 Points That Prove Biking Is A Form Of Therapy',
        description: '10 Points That Prove Biking Is A Form Of Therapy',
        // path:
        // 'https://news.google.com/articles/CAIiEJS8aLG1fl-DjABPRy7LTakqFAgEKgwIACoFCAowhgIwkDgw0O8B?hl=en-IN&gl=IN&ceid=IN%3Aen',
        imagePath:
            'https://www.tvsmotor.com/-/media/Feature/Blog/Did-you-know/Benefits-of-Biking.jpg?h=675&w=1200&la=en&hash=525DFA8CC3DD63D3488CEEC42EEEB70A',
        publishedAt: 'null',
        sourceName: "News",
        sourceId: "1"),
    new News(
        title: 'Helmet Safety Ratings Explained',
        content: '10 Points That Prove Biking Is A Form Of Therapy',
        description: 'What Do They Encompass; DOT, ECE And Snell ',
        // path:
        // 'https://news.google.com/articles/CAIiEJS8aLG1fl-DjABPRy7LTakqFAgEKgwIACoFCAowhgIwkDgw0O8B?hl=en-IN&gl=IN&ceid=IN%3Aen',
        imagePath:
            'https://www.tvsmotor.com/-/media/Feature/Blog/Did-you-know/Helmet-Safety-Ratings.jpg?h=675&w=1200&la=en&hash=1BE8FC82F21CB56E54942F9D8FD5095E',
        publishedAt: 'null',
        sourceName: "News",
        sourceId: "2")
  ];

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
              height: 350,
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
        Expanded(
            child: ListView.builder(
          itemBuilder: (BuildContext ctxt, int index) {
            return _buildListItem(news[index], ctxt);
          },
          itemCount: news.length,
        ))
      ]),
    );
  }

  _buildListItem(News news, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 5, left: 15, bottom: 5, right: 5),
                child: Text(
                    news.title == null || news.title.isEmpty
                        ? "NA"
                        : news.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            Container(
                margin: EdgeInsets.only(bottom: 5, left: 18),
                child: Text(
                  "Source: TVS motors website",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.left,
                )),
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 0),
              decoration: BoxDecoration(color: Colors.grey),
              child: news.imagePath == null || news.imagePath.isEmpty
                  ? SizedBox(
                      height: 10,
                    )
                  : Image.network(news.imagePath, fit: BoxFit.fitWidth),
            ),
            Container(
                margin: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                    news.description == null || news.description.isEmpty
                        ? "NA"
                        : news.description,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            Divider(
              height: 20,
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  tooltip: "Share",
                  onPressed: () {},
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
    );
  }
}

class Dash extends StatelessWidget {
  static const String _title = 'TvsCredit';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Color(0xFF083386),
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MainPage(title: "KYC ")));
    } else if (_selectedIndex == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Registration(title: "Vehicle Registration")));
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
        title: Text('Home'),
        toolbarHeight: 60,

        backgroundColor: Color(0xFF083386),
        //  leading: Icon(Icons.arrow_right_outlined, color: Colors.blue[900]),

        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF083386)),
              accountName: Text(
                "Welcome",
                textAlign: TextAlign.center,
              ),
              accountEmail: Text("abcd@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  "A",
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Dash()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Logg()));
              },
            ),
          ],
        ),
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
              // backgroundColor: Colors.blue,//1
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'KYC',
              // backgroundColor: Colors.blue,//1
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Registration',
              // backgroundColor: Colors.blue,//1
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth_audio),
              label: 'OBD',
              // backgroundColor: Colors.blue,//1
            ),
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.white,//1
          // unselectedItemColor: const Color(0xFF90CAF9),//1
          selectedItemColor: const Color(0xFF253C80), //2
          unselectedItemColor: const Color(0xFF757575), //2
          onTap: _onItemTapped,
          iconSize: 25,
          elevation: 25.25),
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
          backgroundColor: Color(0xFF083386),
          leading: Icon(Icons.arrow_right_outlined, color: Color(0xFF083386)),
          toolbarHeight: 60,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20, top: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dash()));
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ))),
          ],
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
