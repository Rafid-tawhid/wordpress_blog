import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_blog/const/domain.dart';
import 'package:wordpress_blog/dashboard.dart';
import 'package:wordpress_blog/login_screen.dart';
import 'package:wp_json_api/enums/wp_auth_type.dart';
import 'package:wp_json_api/models/responses/wp_user_info_response.dart';
import 'package:wp_json_api/models/responses/wp_user_login_response.dart';
import 'package:wp_json_api/wp_json_api.dart';
import 'package:http/http.dart' as http;

class WordPressUrl extends StatelessWidget {
   WordPressUrl({super.key});
  final domainCon=TextEditingController();
  final loginCon=TextEditingController();


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
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Border color
                    width: 2.0,         // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                child: TextField(
                  controller: loginCon,
                  decoration: InputDecoration(
                    hintText: 'Enter your Login Url',
                    prefix: Text('https://',style: TextStyle(color: Colors.black),),
                    contentPadding: EdgeInsets.all(8.0), // Padding inside the TextField
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                if(domainCon.text.isEmpty||loginCon.text.isEmpty){
                  return;
                }
                else {
                  final pref=await SharedPreferences.getInstance();
                  await pref.setString('login', loginCon.text);
                  pref.setString('domain',domainCon.text).then((value){
                    MyConst.domainUrl=domainCon.text;
                    MyConst.loginUrl=loginCon.text;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen())).then((value) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                    });
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


// class WordPressUrl extends StatefulWidget {
//   WordPressUrl({Key? key,this.title=''}) : super(key: key);
//
//   final String title;
//
//   @override
//   _WordPressUrlState createState() => _WordPressUrlState();
// }
//
// class _WordPressUrlState extends State<WordPressUrl> {
//   late TextEditingController _tfEmailController;
//   late TextEditingController _tfPasswordController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // INSTALL THE WP JSON API PLUGIN
//     // FIRST ON YOUR WORDPRESS STORE
//     // LINK https://woosignal.com/plugins/wordpress/wp-json-api
//
//     WPJsonAPI.instance.initWith(baseUrl: "http://dev.bitbirds.net/rafid/login11");
//
//     _tfEmailController = TextEditingController();
//     _tfPasswordController = TextEditingController();
//   }
//
//   _login() async {
//     String email = _tfEmailController.text;
//     String password = _tfPasswordController.text;
//
//     WPUserLoginResponse? wpUserLoginResponse;
//     // LOGIN
//     try {
//       wpUserLoginResponse = await WPJsonAPI.instance.api((request) =>
//           request.wpLogin(
//               email: 'rafid@bitbirds.com', password: 'Rafid123\$', authType: WPAuthType.WpEmail));
//     } on Exception catch (e) {
//       print(e);
//     }
//
//     if (wpUserLoginResponse != null) {
//       print(wpUserLoginResponse.data?.userToken);
//       print(wpUserLoginResponse.data?.userId);
//
//       // GET USER INFO
//       WPUserInfoResponse? wpUserInfoResponse =
//       await WPJsonAPI.instance.api((request) {
//         return request.wpGetUserInfo(wpUserLoginResponse!.data!.userToken!);
//       });
//
//       if (wpUserInfoResponse != null) {
//         print(wpUserInfoResponse.data?.firstName);
//         print(wpUserInfoResponse.data?.lastName);
//       } else {
//         print("something went wrong");
//       }
//     } else {
//       print("invalid login details");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _tfEmailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 hintText: 'Email'
//               ),
//             ),
//             SizedBox(height: 20,),
//             TextField(
//               controller: _tfPasswordController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                   hintText: 'Password'
//               ),
//               obscureText: true,
//             ),
//             MaterialButton(
//               child: Text("Login"),
//               onPressed: _login,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }