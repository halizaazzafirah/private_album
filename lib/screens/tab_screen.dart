import 'package:flutter/material.dart';
import 'package:private_photo_album/screens/gallery_screen.dart';
import 'package:private_photo_album/screens/add_photo_screen.dart';
import 'package:private_photo_album/services/theme_changer.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tab_screen';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': AddPhotoScreen(),
      'title': 'Add a Photo',
    },
    {
      'page': GalleryScreen(),
      'title': 'My Gallery',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // Change theme
  void _changeTheme() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 24.0,
            ),
            child: ThemeChanger(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('Theme'),
            onPressed: () => _changeTheme(),
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Colors.blueGrey[400],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black45,
        currentIndex: _selectedPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Images',
          ),
        ],
      ),
    );
  }
}
