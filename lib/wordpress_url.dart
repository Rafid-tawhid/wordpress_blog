import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_blog/const/domain.dart';
import 'package:wordpress_blog/dashboard.dart';

class WordPressUrl extends StatelessWidget {
   WordPressUrl({super.key});
  final domainCon=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Welcome'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Border color
                    width: 2.0,         // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: TextField(
                  controller: domainCon,
                  decoration: InputDecoration(
                    hintText: 'Enter your domain',
                    prefix: Text('https://',style: TextStyle(color: Colors.black),),
                    contentPadding: EdgeInsets.all(8.0), // Padding inside the TextField
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                if(domainCon.text.isEmpty){
                  return;
                }
                else {
                  final pref=await SharedPreferences.getInstance();
                  pref.setString('domain',domainCon.text).then((value){
                    MyConst.domainUrl=domainCon.text;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Dashboard()));
                  });

                }

              }, child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
