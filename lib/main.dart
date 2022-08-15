import 'package:flutter/material.dart';
import 'package:current_activity/widget/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    //  Orientation orientation = MediaQuery.of(context).orientation;
    return MaterialApp(
        title: 'Cards',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: Center(child: MainPage())
        ));
  }
}