import 'package:flutter/material.dart';

class QuizerTheme {
  static const defaultVerticalSpacer = SizedBox(height: 4);

  static const defaultInset = EdgeInsets.symmetric(
    vertical: 4.0,
    horizontal: 8.0,
  );

  static const defaultTextFieldDecoration = InputDecoration(
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ),
  );
}
