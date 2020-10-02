import 'package:flutter/material.dart';
import 'package:thebrand/values/colors.dart';

class BrandImage extends StatelessWidget {
  final String image;

  const BrandImage({Key key, @required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.network(image, fit: BoxFit.contain, loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
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
    });
  }
}
