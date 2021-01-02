import 'package:tvscred/widget/text_recognition_widget.dart';
import 'package:flutter/material.dart';
import 'splash.dart';
import './widget/dash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Scan and upload details';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primaryColor: Color(0xFF083386), backgroundColor: Colors.black),
        home: AnimatedSplashScreen(),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  get theme => null;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            toolbarHeight: 60,
            leading: Icon(Icons.arrow_right_outlined, color: Color(0xFF083386)),
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
            centerTitle: true,
            backgroundColor: Color(0xFF083386)),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextRecognitionWidget(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}
