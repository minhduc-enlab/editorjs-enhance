import 'package:editorjs_flutter/editorjs_flutter.dart';
import 'package:flutter/material.dart';

class CreateNoteLayout extends StatefulWidget {
  @override
  CreateNoteLayoutState createState() => CreateNoteLayoutState();
}

class CreateNoteLayoutState extends State<CreateNoteLayout> {
  EditorJSEditor editorJSEditor;

  @override
  void initState() {
    super.initState();
    fetchTestData();
  }

  void fetchTestData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("test_data/editorjsdatatest.json");
    String styles = await DefaultAssetBundle.of(context)
        .loadString("test_data/editorjsstyles.json");

    setState(() {
      editorJSEditor = EditorJSEditor(
        editorJSData: data,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Note")),
        body: SingleChildScrollView(
            child: Column(
          children: [
            (editorJSEditor != null) ? editorJSEditor : Text("Please wait")
          ],
        )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
