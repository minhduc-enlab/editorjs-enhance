import 'package:editorjs_flutter/src/model/EditorJSBlockFile.dart';

class EditorJSBlockData {
  String? text;
  final int? level;
  final String? style;
  final List<String>? items;
  final EditorJSBlockFile? file;
  final String? caption;
  final bool? withBorder;
  final bool? stretched;
  final bool? withBackground;

  EditorJSBlockData(
      {this.text,
      this.level,
      this.style,
      this.items,
      this.file,
      this.caption,
      this.withBorder,
      this.stretched,
      this.withBackground});

  factory EditorJSBlockData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List?;
    final List<String> itemsList = <String>[];

    if (list != null) {
      list.forEach((element) {
        itemsList.add(element);
      });
    }

    return EditorJSBlockData(
        text: parsedJson['text'],
        level: parsedJson['level'],
        style: parsedJson['style'],
        items: itemsList,
        file: (parsedJson['file'] != null)
            ? EditorJSBlockFile.fromJson(parsedJson['file'])
            : null,
        caption: parsedJson['caption'],
        withBorder: parsedJson['withBorder'],
        withBackground: parsedJson['withBackground']);
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (text != null) {
      result.addAll({'text': text});
    }
    if (level != null) {
      result.addAll({'level': level});
    }
    if (style != null) {
      result.addAll({'style': style});
    }
    if (items != null && items!.isNotEmpty) {
      result.addAll({'items': items});
    }
    if (file != null) {
      result.addAll({'file': file!.toJson()});
    }
    if (caption != null) {
      result.addAll({'caption': caption});
    }
    if (withBorder != null) {
      result.addAll({'withBorder': withBorder});
    }
    if (stretched != null) {
      result.addAll({'stretched': stretched});
    }
    if (withBackground != null) {
      result.addAll({'withBackground': withBackground});
    }

    return result;
  }
}
