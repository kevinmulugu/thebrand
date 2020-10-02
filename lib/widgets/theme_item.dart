import 'package:flutter/material.dart';
import 'package:thebrand/values/colors.dart';
import 'package:thebrand/widgets/brand_image.dart';

class ThemeItem extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const ThemeItem({Key key, @required this.image, @required this.title, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
          child: Card(
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: BrandImage(image: image),
            ),
            Container(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: kGray700Color),
            ))
          ],
        ),
      ),
    );
  }
}
