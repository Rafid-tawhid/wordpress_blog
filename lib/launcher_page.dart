import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog/home_page.dart';
import 'package:wordpress_blog/service/request_service.dart';
import 'package:wordpress_blog/show_blog.dart';

import 'add_new_page.dart';
import 'widgets/drawer.dart';
import 'post_page.dart';

class MyExample extends StatefulWidget {
  @override
  _MyExampleState createState() => _MyExampleState();
}


class _MyExampleState extends State<MyExample> {

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Exit'),
        content: Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  int _selectedIndex = 0; //default index

  List<Widget> _widgetOptions = [
    HomePage(),
    AddNewPostPage(),
    //HtmlEditorExample(title: 'HTML',),
    AddNewPages(),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(title: Text('Wordpress'),),
        drawer: MyDrawer(),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: CustomLineIndicatorBottomNavbar(
          selectedColor: Colors.blue,
          unSelectedColor: Colors.black54,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          unselectedIconSize: 15,
          selectedIconSize: 20,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          enableLineIndicator: true,
          lineIndicatorWidth: 3,
          indicatorType: IndicatorType.Top,
          // gradient: LinearGradient(
          //   colors: [Colors.pink, Colors.yellow],
          // ),
          customBottomBarItems: [
            CustomBottomBarItems(
              label: 'Home',
              icon: Icons.home,
            ),
            CustomBottomBarItems(
              label: 'Post',
              icon: Icons.post_add,
            ),
            CustomBottomBarItems(
                label: 'Pages', icon: Icons.contact_page_outlined),

          ],
        ),
      ),
    );
  }
}