import 'package:flutter/material.dart';
import 'package:thebrand/values/colors.dart';

class ThemeItem extends StatelessWidget {
  final String image;
  final String title;

  const ThemeItem({Key key, @required this.image, @required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(image, fit: BoxFit.cover, loadingBuilder:
              (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
                backgroundColor: kBottomNavigationSelectedItemColor,
              ),
            );
          }),
          Text(title, style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}
