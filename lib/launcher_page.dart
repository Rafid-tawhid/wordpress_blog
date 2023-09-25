import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog/home_page.dart';
import 'package:wordpress_blog/service/request_service.dart';
import 'package:wordpress_blog/show_blog.dart';

import 'post_page.dart';

class MyExample extends StatefulWidget {
  @override
  _MyExampleState createState() => _MyExampleState();
}


class _MyExampleState extends State<MyExample> {
  int _selectedIndex = 0; //default index

  List<Widget> _widgetOptions = [
    HomePage(),
    WebViewExample(),
    //HtmlEditorExample(title: 'HTML',),
    ShowBlogPage()
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
            label: 'Edit',
            icon: Icons.edit,
          ),
          CustomBottomBarItems(
              label: 'Blog', icon: Icons.credit_card_outlined),

        ],
      ),
    );
  }
}