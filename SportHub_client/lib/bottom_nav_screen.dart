import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  BottomNavScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNavScreenState();
  }
}

class BottomNavScreenState extends State<BottomNavScreen> {
  var currentPage = 0;
  var pages = [
    Text('Feed'),
    Text('Search'),
    Text('New'),
    Text('Trains'),
    Text('Profile')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bottom navigation',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Bottom navigation',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
            child: pages.elementAt(currentPage),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'New'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility_new_sharp), label: 'Trains'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: currentPage,
            fixedColor: Colors.red,
            onTap: (int intIndex) {
              setState(() {
                currentPage = intIndex;
              });
            },
          ),
        ));
  }
}
