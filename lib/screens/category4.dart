import 'package:flutter/material.dart';

class Category4Screen extends StatelessWidget {
  final String title;

  const Category4Screen({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}