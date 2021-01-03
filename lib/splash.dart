import 'package:flutter/material.dart';

import 'dart:async';

//import './login/login_page.dart';
import 'log.dart';

class MyApps extends StatelessWidget {
  final String title = 'Welcome';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primaryColor: Color(0xFF083386), backgroundColor: Colors.black),
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
        color: Color(0xFFFFFFFF),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjUOlpOI_Qm9kR4jgSLSo3ckrheZcN5Gdwmg&usqp=CAU"),
          )),
        ));
  }
}

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                //MainPage(title: "Text Recognization")
                //SignInDemo()
                //  Dash()
                Logg()));
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/images/dan.jpg',
                width: animation.value * 350,
                height: animation.value * 350,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
