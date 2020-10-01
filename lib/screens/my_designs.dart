import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:thebrand/models/brand_theme.dart';
import 'package:thebrand/widgets/theme_item.dart';

class MyDesignsScreen extends StatefulWidget {
  @override
  _MyDesignsScreenState createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen> {
  final String themesUrl =
      'http://itsthebrand.com/brandAPI/mode.php?mode=getThemes&userid=22&page=1';
  Future<List<BrandTheme>> futureBrandThemes;

  @override
  void initState() {
    futureBrandThemes = getThemes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text('New Designs'),
          subtitle: Text('Browse our latest designs'),
          trailing: FaIcon(FontAwesomeIcons.arrowRight),
        ),
        Flexible(
                  child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/4-100,
            width: double.infinity,
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
                          image: snapshot.data[index].picture,
                          title: snapshot.data[index].title);
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }

                // By default, show a loading spinner.
                return Center(child: Container(height: 50.0, width: 50.0, child: CircularProgressIndicator()));
              },
            ),
          ),
        )
      ],
    );
  }

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
}
