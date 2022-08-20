import 'package:current_activity/widget/cool/providers.dart';
import 'package:flutter/material.dart';
import 'package:current_activity/widget/main_page.dart';
import 'package:flutter_cool_card_swiper/pages/home_page.dart';
import 'package:current_activity/widget/cool/DemoCool.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Opaciter()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    //  Orientation orientation = MediaQuery.of(context).orientation;
    return MaterialApp(
        title: 'Cards 1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(body: Center(child: DemoCool())));
  }
}
