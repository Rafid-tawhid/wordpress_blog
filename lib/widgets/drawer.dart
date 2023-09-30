import 'package:flutter/material.dart';

import '../add_new_page.dart';
import '../show_blog.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Show blog'),
            onTap: () {
              // Add the action you want to perform when this item is tapped.
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ShowBlogPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Add the action you want to perform when this item is tapped.
            },
          ),
        ],
      ),
    );
  }
}
