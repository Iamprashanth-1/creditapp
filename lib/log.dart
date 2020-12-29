import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import './widget/dash.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  'abcd@gmail.com': '12345',
  'mpr5045@gmail.com': 'mpr5045',
};

class Logg extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );
    Future<String> _authUser(LoginData data) {
      print('Name: ${data.name}, Password: ${data.password}');
      return Future.delayed(loginTime).then((_) {
        if (!users.containsKey(data.name)) {
          return 'Username not exists';
        }
        if (users[data.name] != data.password) {
          return 'Password does not match';
        }
        return null;
      });
    }

    Future<String> _recoverPassword(String name) {
      print('Name: $name');
      return Future.delayed(loginTime).then((_) {
        if (!users.containsKey(name)) {
          return 'Username not exists';
        }
        return null;
      });
    }

    return FlutterLogin(
      title: 'TVSCREDIT',
      logo: 'assets/images/dan.jpg',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dash(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.blue,
        errorColor: Colors.blue,
        titleStyle: TextStyle(
          color: Colors.blue,
          fontFamily: 'Quicksand',
          fontStyle: FontStyle.italic,
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.blue,
          shadows: [Shadow(color: Colors.white, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.blue[100],
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(75.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.white,
            color: Colors.blue,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          //splashColor: Colors.black,

          backgroundColor: Colors.blue[300],
          // highlightColor: Colors.lightGreen,
          elevation: 15.0,
          highlightElevation: 8.0,

          //shape: BeveledRectangleBorder(
          //  borderRadius: BorderRadius.circular(10),
          //),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}
