import 'package:flutter/material.dart';
import 'package:thebrand/values/colors.dart';

class BrandAppBar extends StatefulWidget {
  @override
  _BrandAppBarState createState() => _BrandAppBarState();
}

class _BrandAppBarState extends State<BrandAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200], width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu),
          Container(
            child: CircleAvatar(
              backgroundColor: kCircularAvatarBackgroundColor,
              child: Text(
                'S',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
