import 'package:flutter/material.dart';

import 'package:tvscred/widget/text_recognition_widget.dart';
import 'dart:async';
import 'main.dart';
//import './login/login_page.dart';
import 'log.dart';

class MyApps extends StatelessWidget {
  final String title = 'Welcome';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primarySwatch: Colors.blue, backgroundColor: Colors.black),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    //MainPage(title: "Text Recognization")
                    //SignInDemo()
                    //  Dash()
                    Logg())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                "https://th.bing.com/th/id/OIP.7Ee6fac3lfxTtM0hvkmyIQHaHa?w=192&h=192&c=7&o=5&dpr=1.25&pid=1.7"),
          )),
        ));
  }
}
