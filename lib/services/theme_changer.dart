import 'package:flutter/material.dart';
import 'package:private_photo_album/providers/themes.dart';
import 'package:provider/provider.dart';

class ThemeChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Themes _theme = Provider.of<Themes>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text(
              'Dark Theme',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            color: Colors.black,
            onPressed: () => _theme.setTheme(ThemeData.dark()),
          ),
          FlatButton(
            child: Text(
              'Light Theme',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            color: Colors.grey[50],
            onPressed: () => _theme.setTheme(ThemeData.light()),
          ),
        ],
      ),
    );
  }
}
