import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:thebrand/models/brand_theme.dart';
import 'package:thebrand/screens/design_details.dart';
import 'package:thebrand/values/colors.dart';
import 'package:thebrand/values/strings.dart';
import 'package:thebrand/widgets/theme_item.dart';

class MyDesignsScreen extends StatefulWidget {
  @override
  _MyDesignsScreenState createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen> {
  // The brand themes url
  final String themesUrl =
      'http://itsthebrand.com/brandAPI/mode.php?mode=getThemes&userid=22&page=1';
  Future<List<BrandTheme>> futureBrandThemes;

  @override
  void initState() {
    // load themes
    futureBrandThemes = getThemes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: kBottomNavigationSelectedItemColor,
                            width: 3))),
                child: Text(kCategory1Label),
              ),
              Container(
                child: Text(kCategory2Label),
              ),
              Container(
                child: Text(kCategory3Label),
              ),
              Container(
                child: Text(kCategory4Label),
              )
            ],
          ),
        ),
        ListTile(
          title: Text('New Designs',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Browse our latest designs',
              style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: FaIcon(FontAwesomeIcons.arrowRight),
        ),
        Expanded(
          child: FutureBuilder<List<BrandTheme>>(
            future: futureBrandThemes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List.generate(snapshot.data.length, (index) {
                    return ThemeItem(
                        onTap: () {
                          onDesignItemClicked(snapshot.data[index].catalogid,
                              snapshot.data[index].id);
                        },
                        image: snapshot.data[index].picture,
                        title: snapshot.data[index].title);
                  }),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }

              // By default, show a loading spinner.
              return Center(
                  child: Container(
                      height: 50.0,
                      width: 50.0,
                      child: CircularProgressIndicator()));
            },
          ),
        )
      ],
    );
  }

  ///
  /// Loads the themes from the brands API
  ///
  ///
  Future<List<BrandTheme>> getThemes() async {
    final response = await http.post(themesUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsedJson = json.decode(response.body)['themes'];
      return (parsedJson as List).map((e) => BrandTheme.fromJson(e)).toList();
      // return [];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  onDesignItemClicked(String catalodId, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DesignDetailsScreen(designId: id, userId: catalodId)),
    );
  }
}
