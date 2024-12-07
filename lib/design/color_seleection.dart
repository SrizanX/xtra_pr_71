import 'package:flutter/material.dart';

enum ColorSelection {
  white('White', Colors.white),
  deepPurple('Deep Purple', Colors.deepPurple),
  purple('Purple', Colors.purple),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink),
  darkBlue('Dark Blue', Color.fromRGBO(41, 43, 68, 1.0)),
  darkBlueTransparent('Dark Blue', Color.fromRGBO(41, 43, 68, 100)),
  blue_500('Blue 500', Color(0xff5492f7));

  const ColorSelection(
    this.label,
    this.color,
  );

  final String label;
  final Color color;
}
