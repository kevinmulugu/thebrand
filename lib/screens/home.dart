import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thebrand/screens/category3.dart';
import 'package:thebrand/screens/category4.dart';
import 'package:thebrand/screens/marketplace.dart';
import 'package:thebrand/screens/my_designs.dart';
import 'package:thebrand/values/colors.dart';
import 'package:thebrand/values/strings.dart';
import 'package:thebrand/values/styles.dart';
import 'package:thebrand/widgets/brand_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _theBrandWidgets = <Widget>[
  MarketplaceScreen(title: kMarketplaceLabel),
  MyDesignsScreen(),
  Category3Screen(title: kCategory3Label),
  Category4Screen(title: kCategory4Label)
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BrandAppBar(),
              Expanded(child: _theBrandWidgets.elementAt(_selectedIndex))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gamepad),
          title: Text(kMarketplaceLabel, style: bottomNavigationTextStyle),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.thLarge),
          title: Text(kMyDesignsLabel, style: bottomNavigationTextStyle),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.listAlt),
          title: Text(kCategory3Label, style: bottomNavigationTextStyle),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.clipboard),
          title: Text(kCategory4Label, style: bottomNavigationTextStyle),
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: kBottomNavigationUnselectedItemColor,
      selectedItemColor: kBottomNavigationSelectedItemColor,
      onTap: _onItemTapped,
      showUnselectedLabels: true,
    )
    );
  }
}
