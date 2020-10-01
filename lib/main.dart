import 'package:flutter/material.dart';
import 'package:thebrand/screens/home.dart';
import 'package:thebrand/values/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}