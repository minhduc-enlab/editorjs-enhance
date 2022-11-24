import 'package:flutter/material.dart';

class TextComponent {
  static Widget addText(
      {double size = 14,
      FontWeight weight = FontWeight.w400,
      TextEditingController? textEditingController,
      void Function(String)? onChanged}) {
    return TextField(
      autofocus: true,
      controller: textEditingController,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(border: InputBorder.none),
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: null,
    );
  }
}
