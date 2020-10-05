import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thebrand/models/layer.dart';
import 'package:http/http.dart' as http;

class DesignLayerScreen extends StatefulWidget {
  // The image thumbnail, poster from prev screen
  final String thumbnail;
  final String id;

  const DesignLayerScreen(
      {Key key, @required this.thumbnail, @required this.id})
      : super(key: key);
  @override
  _DesignLayerScreenState createState() => _DesignLayerScreenState();
}

class _DesignLayerScreenState extends State<DesignLayerScreen> {
  Future<List<DesignLayer>> futureDesignLayers;

  @override
  void initState() {
    // load themes
    futureDesignLayers = getDesignLayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Design Layer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.0),
        child: FutureBuilder<List<DesignLayer>>(
          future: futureDesignLayers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              widget.thumbnail,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: snapshot.data
                            .map((layer) => Column(
                                  children: [
                                    ListTile(
                                      title: Text(layer.text),
                                    ),
                                    Divider()
                                  ],
                                ))
                            .toList(),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: 'Refresh',
                                icon: Icon(
                                  Icons.refresh,
                                  color: Color(0xFFFCC44D),
                                ),
                                onPressed: () {
                                  getDesignLayers();
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  ///
  /// Loads the themes from the brands API
  ///
  ///
  Future<List<DesignLayer>> getDesignLayers() async {
    final String url =
        'http://itsthebrand.com/brandAPI/mode.php?mode=getDesignForm&userid=4343&designID=${widget.id}';
    final response = await http.post(url);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsedJson =
          json.decode(json.decode(response.body)['designDetails'][0]['layers']);
      return (parsedJson as List).map((e) => DesignLayer.fromJson(e)).toList();
      // return [];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
