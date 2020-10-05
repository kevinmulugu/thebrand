import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thebrand/models/design_detail.dart';
import 'package:thebrand/screens/design_layers.dart';
import 'package:thebrand/values/strings.dart';
import 'package:http/http.dart' as http;
import 'package:thebrand/widgets/brand_image.dart';

class DesignDetailsScreen extends StatefulWidget {
  final String userId;
  final String designId;

  const DesignDetailsScreen(
      {Key key, @required this.userId, @required this.designId})
      : super(key: key);
  @override
  _DesignDetailsScreenState createState() => _DesignDetailsScreenState();
}

class _DesignDetailsScreenState extends State<DesignDetailsScreen> {
  Future<DesignDetail> futureDesignDetail;
  @override
  void initState() {
    futureDesignDetail = getDesignDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black54, //change your color here
        ),
        title: Text(
          kMarketplaceLabel,
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: null),
          IconButton(icon: Icon(Icons.more_vert), onPressed: null),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DesignDetail>(
          future: futureDesignDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 60.0,
                            width: 60.0,
                            child: BrandImage(image: snapshot.data.picture)),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data.title),
                                subtitle: Text(snapshot.data.alias),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DesignLayerScreen(
                                          thumbnail: snapshot.data.picture,
                                          id: snapshot.data.id,
                                        )),
                              );
                            },
                            color: Colors.green,
                            child: Text('Button',
                                style: TextStyle(color: Colors.white)))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Colors.grey[200], width: 1),
                        bottom: BorderSide(color: Colors.grey[200], width: 1),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Text(snapshot.data.category)),
                          Container(child: Text(snapshot.data.public)),
                          Container(child: Text(snapshot.data.adddate)),
                          Container(child: Text(snapshot.data.viewnum)),
                        ],
                      ),
                    ),
                    Container(
                      child: BrandImage(image: snapshot.data.picture),
                    ),
                    Container(child: Text(snapshot.data.description))
                  ],
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

  Future<DesignDetail> getDesignDetails() async {
    String designDetailsUrl =
        'http://itsthebrand.com/brandAPI/mode.php?mode=getDesignDetails&userid=${widget.userId}&designID=${widget.designId}';
    final response = await http.post(designDetailsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsedJson = json.decode(response.body)['designDetails'][0];
      return DesignDetail.fromJson(parsedJson);
      // return [];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load details');
    }
  }
}
