import 'package:smart_parking/pages/profile.dart';
import 'package:smart_parking/setup/signin.dart';
import 'package:smart_parking/pages/home.dart';
import 'package:smart_parking/setup/register.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/setup/login.dart';
import 'MessagingWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'loginUI',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => Home(),
        '/loginPage':(BuildContext context) => Login(),
        '/registerPage':(BuildContext context) => Register(),
        '/notificationPage':(BuildContext context) => MessagingWidget(),
        '/profilePage': (BuildContext context) => Profile(),
      },
      home: Register(),
    );
  }
}
