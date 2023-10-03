import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_blog/post_page.dart';
import 'package:wordpress_blog/login_screen.dart';
import 'package:wordpress_blog/wordpress_url.dart';

import 'add_new_page.dart';
import 'comment_page.dart';
import 'home_page.dart';
import 'main.dart';
import 'media_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Post','Pages','Custom Post','Media','Comments','Change Url','Login'];
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            mainAxisSpacing: 10.0, // Spacing between rows
            crossAxisSpacing: 10.0, // Spacing between columns
          ),
          itemCount: items.length, // Total number of items in the grid
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                // Navigate to the DetailPage when a grid item is tapped
                if(items[index]=='Post'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewPostPage(),
                    ),
                  );
                }
                if(items[index]=='Pages'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewPages(),
                    ),
                  );
                }
                if(items[index]=='Custom Post'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
                if(items[index]=='Media'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MediaPage(),
                    ),
                  );
                }
                if(items[index]=='Comments'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentsPage(),
                    ),
                  );
                }
                if(items[index]=='Change Url'){
                  final pref=await SharedPreferences.getInstance();
                  pref.remove("domain");
                  pref.remove("login");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordPressUrl(),
                    ),
                  );
                }
                if(items[index]=='Login'){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                }

              },
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    items[index],
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
