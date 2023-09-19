import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController con1=TextEditingController();
  TextEditingController con2=TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(

          children: [
            TextField(
              decoration: InputDecoration(labelText: 'title'),
              controller: con1,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'content'),
              controller: con2,
            ),
            SizedBox(height: 10,),


      //       HtmlEditor(
      //   controller: controller,
      //   htmlEditorOptions: HtmlEditorOptions(
      //     hint: 'Your text here...',
      //     shouldEnsureVisible: true,
      //     //initialText: "<p>text content initial, if any</p>",
      //   ),
      //   htmlToolbarOptions: HtmlToolbarOptions(
      //     toolbarPosition: ToolbarPosition.aboveEditor, //by default
      //     toolbarType: ToolbarType.nativeScrollable, //by default
      //     onButtonPressed:
      //         (ButtonType type, bool? status, Function? updateStatus) {
      //       print(
      //           "button '${describeEnum(type)}' pressed, the current selected status is $status");
      //       return true;
      //     },
      //     onDropdownChanged: (DropdownType type, dynamic changed,
      //         Function(dynamic)? updateSelectedItem) {
      //       print(
      //           "dropdown '${describeEnum(type)}' changed to $changed");
      //       return true;
      //     },
      //     mediaLinkInsertInterceptor:
      //         (String url, InsertFileType type) {
      //       print(url);
      //       return true;
      //     },
      //     // mediaUploadInterceptor:
      //     //     (PlatformFile file, InsertFileType type) async {
      //     //   print(file.name); //filename
      //     //   print(file.size); //size in bytes
      //     //   print(file.extension); //file extension (eg jpeg or mp4)
      //     //   return true;
      //     // },
      //   ),
      //   otherOptions: OtherOptions(height: 550),
      //   callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
      //     print('html before change is $currentHtml');
      //   }, onChangeContent: (String? changed) {
      //     print('content changed to $changed');
      //   }, onChangeCodeview: (String? changed) {
      //     print('code changed to $changed');
      //   }, onChangeSelection: (EditorSettings settings) {
      //     print('parent element is ${settings.parentElement}');
      //     print('font name is ${settings.fontName}');
      //   }, onDialogShown: () {
      //     print('dialog shown');
      //   }, onEnter: () {
      //     print('enter/return pressed');
      //   }, onFocus: () {
      //     print('editor focused');
      //   }, onBlur: () {
      //     print('editor unfocused');
      //   }, onBlurCodeview: () {
      //     print('codeview either focused or unfocused');
      //   }, onInit: () {
      //     print('init');
      //   },
      //       onImageUploadError: (FileUpload? file, String? base64Str,
      //           UploadError error) {
      //         print(describeEnum(error));
      //         print(base64Str ?? '');
      //         if (file != null) {
      //           print(file.name);
      //           print(file.size);
      //           print(file.type);
      //         }
      //       }, onKeyDown: (int? keyCode) {
      //         print('$keyCode key downed');
      //         print(
      //             'current character count: ${controller.characterCount}');
      //       }, onKeyUp: (int? keyCode) {
      //         print('$keyCode key released');
      //       }, onMouseDown: () {
      //         print('mouse downed');
      //       }, onMouseUp: () {
      //         print('mouse released');
      //       }, onNavigationRequestMobile: (String url) {
      //         print(url);
      //         return NavigationActionPolicy.ALLOW;
      //       }, onPaste: () {
      //         print('pasted into editor');
      //       }, onScroll: () {
      //         print('editor scrolled');
      //       }),
      //   plugins: [
      //     SummernoteAtMention(
      //         getSuggestionsMobile: (String value) {
      //           var mentions = <String>['test1', 'test2', 'test3'];
      //           return mentions
      //               .where((element) => element.contains(value))
      //               .toList();
      //         },
      //         mentionsWeb: ['test1', 'test2', 'test3'],
      //         onSelect: (String value) {
      //           print(value);
      //         }),
      //   ],
      // ),

            FlutterSummernote(
              hint: 'Your text here...',
              key: _keyEditor,
              hasAttachment: true,
              customToolbar: """
          [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['insert', ['link', 'table', 'hr']]
          ]
        """,
            ),

            ElevatedButton(onPressed: () async {
              // var txt = await controller.getText();
              // print(txt);
               postBlog(con1.text, con2.text);

             // summernote();
            }, child: Text('Submit'))
          ],
        ),
      )
    );
  }

  Future<void> postBlog(String title, String content) async {
    final String apiUrl = 'https://dev.bitbirds.net/rafid/wp-json/wp/v2/posts';
    final String username = 'rafid';
    final String password = 'J9i5FIS6yyta3eusVUWnvHLP';
    final value = (await _keyEditor.currentState?.getText());
    print('VALUE ${value}');
    EasyLoading.show();
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      },
      body: jsonEncode({
        'title': title,
        'content': value,
        'content_filtered': value,
        'status': 'publish',
      }),
    );
    print('WP-RESPONSE ${response.body.toString()}');

    if (response.statusCode == 201) {
      print('Blog posted successfully');
      EasyLoading.dismiss();
      setState(() {
        con1.clear();
        con2.clear();
      });
    } else {
      print('Failed to post blog. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
     EasyLoading.dismiss();
    }
  }

  Future<void> summernote() async {
    final value = (await _keyEditor.currentState?.getText());
    print(value);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // duration: Duration(seconds: 5),
    // content: Text(value ?? '-'),
    // ));
  }
}
