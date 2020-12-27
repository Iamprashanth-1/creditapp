import 'package:flutter/material.dart';

import 'package:tvscred/widget/text_recognition_widget.dart';
import 'dart:async';
import 'main.dart';
//import './login/login_page.dart';

class MyApps extends StatelessWidget {
  final String title = 'Text Recognition';

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
                builder: (context) => MainPage(title: "Text Recognization")
                //LoginScreen()
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
