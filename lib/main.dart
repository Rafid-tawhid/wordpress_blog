import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_blog/const/domain.dart';
import 'package:wordpress_blog/wordpress_url.dart';
import 'package:wp_json_api/wp_json_api.dart';

import 'dashboard.dart';
import 'post_page.dart';
import 'home_page.dart';
import 'launcher_page.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    getDomain();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyConst.domainUrl==null?WordPressUrl():Dashboard(),
    );
  }

  void getDomain() async{
    final pref=await SharedPreferences.getInstance();
    final url= pref.getString('domain');
    print('URLSSSS ${url}');
    if(url!=null){
      setState(() {
        MyConst.domainUrl=url;
      });
    }
  }
}


