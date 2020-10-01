import 'package:flutter/material.dart';
import 'package:thebrand/values/strings.dart';

class MarketplaceScreen extends StatelessWidget {
  final String title;

  const MarketplaceScreen({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(kMarketplaceLabel),
    );
  }
}