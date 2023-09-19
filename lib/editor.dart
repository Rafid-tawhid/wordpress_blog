import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              final value = (await _keyEditor.currentState?.getText());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 5),
                content: Text(value ?? '-'),
              ));
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: FlutterSummernote(
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
    );
  }
}