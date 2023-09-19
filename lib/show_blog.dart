import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wordpress_blog/service/request_service.dart';

class ShowBlogPage extends StatefulWidget {
  const ShowBlogPage({super.key});

  @override
  State<ShowBlogPage> createState() => _ShowBlogPageState();
}

class _ShowBlogPageState extends State<ShowBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<dynamic>>(
        future: RequestClass.fetchBlogPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {

                return ListTile(
                  title: Text(posts[index]['title']['rendered']),
                  subtitle: HtmlWidget(posts[index]['excerpt']['rendered']??''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
