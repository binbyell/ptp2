

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Color> selectColor(BuildContext context, Color? selectedColor) async {

  Color tempColor = selectedColor??Colors.black;
  return await showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: tempColor,
          onColorChanged: (Color color) {
            tempColor = color;
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            Navigator.of(context).pop(tempColor);
          },
        ),
      ],
    );
  });
}
