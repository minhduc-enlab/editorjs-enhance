import 'dart:convert';

import 'package:editorjs_flutter/src/model/EditorJSData.dart';
import 'package:editorjs_flutter/src/widgets/components/textcomponent.dart';
import 'package:editorjs_flutter/src/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class EditorJSEditor extends StatefulWidget {
  final String? editorJSData;

  const EditorJSEditor({Key? key, this.editorJSData}) : super(key: key);

  @override
  EditorJSEditorState createState() => EditorJSEditorState();
}

class EditorJSEditorState extends State<EditorJSEditor> with ChangeNotifier {
  final List<Widget> items = <Widget>[];
  final List<TextEditingController> textControllers = <TextEditingController>[];

  late EditorJSData dataObject;

  @override
  void initState() {
    super.initState();
    _loadInitData();
    // setState(() {
    //   items.add(Row(children: [TextComponent.addText()]));
    // });
  }

  void onChangedText(int index, String value) {
    dataObject.blocks![index].data!.text = value;
  }

  void _loadInitData() {
    if (widget.editorJSData != null) {
      setState(
        () {
          dataObject = EditorJSData.fromJson(jsonDecode(widget.editorJSData!));
          // styles = EditorJSViewStyles.fromJson(jsonDecode(widget.styles!));

          // customStyleMap = generateStylemap(styles.cssTags!);

          dataObject.blocks!.asMap().forEach(
            (index, element) {
              double levelFontSize = 16;

              switch (element.data!.level) {
                case 1:
                  levelFontSize = 32;
                  break;
                case 2:
                  levelFontSize = 24;
                  break;
                case 3:
                  levelFontSize = 16;
                  break;
                case 4:
                  levelFontSize = 12;
                  break;
                case 5:
                  levelFontSize = 10;
                  break;
                case 6:
                  levelFontSize = 8;
                  break;
              }

              switch (element.type) {
                case "header":
                  textControllers.add(
                      TextEditingController(text: element.data!.text ?? ''));
                  items.add(
                    TextComponent.addText(
                      size: levelFontSize,
                      textEditingController: textControllers.last,
                      weight: (element.data!.level! <= 3)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      onChanged: (value) {
                        onChangedText(index, value);
                      },
                    ),
                  );
                  break;
                case "paragraph":
                  // log(element.data!.text.toString());
                  textControllers.add(
                    TextEditingController(text: element.data!.text ?? ''),
                  );
                  items.add(
                    TextComponent.addText(
                      textEditingController: textControllers.last,
                      size: 14,
                      weight: FontWeight.w400,
                      onChanged: (value) {
                        onChangedText(index, value);
                      },
                    ),
                  );
                  break;
                // case "list":
                //   String bullet = "\u2022 ";
                //   String? style = element.data!.style;
                //   int counter = 1;

                //   element.data!.items!.forEach(
                //     (element) {
                //       if (style == 'ordered') {
                //         bullet = counter.toString();
                //         items.add(
                //           Row(children: [
                //             Expanded(
                //               child: Container(
                //                   child: Html(
                //                 data: bullet + element,
                //                 style: customStyleMap,
                //               )),
                //             )
                //           ]),
                //         );
                //         counter++;
                //       } else {
                //         items.add(
                //           Row(
                //             children: <Widget>[
                //               Expanded(
                //                   child: Container(
                //                 child: Html(
                //                     data: bullet + element,
                //                     style: customStyleMap),
                //               ))
                //             ],
                //           ),
                //         );
                //       }
                //     },
                //   );
                //   break;
                // case "delimiter":
                //   items.add(Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         // Text('***', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                //         Expanded(child: Divider(color: Colors.grey))
                //       ]));
                //   break;
                // case "image":
                //   items.add(Image.network(element.data!.file!.url!));
                //   break;
              }
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index];
            },
          ),
        ),
        EditorJSToolbar(parent: this)
      ],
    );
  }
}
