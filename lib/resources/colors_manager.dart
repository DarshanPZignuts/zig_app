import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#1E8040");
  static Color secondary = HexColor.fromHex("#8BCC28");
  static Color darkGrey = HexColor.fromHex("#333333");
  static Color Green1 = HexColor.fromHex("#198008");
  static Color lightGreen = HexColor.fromHex("#E5F1E9");
  static Color cardBackground = HexColor.fromHex("#CAE7EB");
  static Color cAvatarBackground = HexColor.fromHex("#70A1A8");
  static Color cardBackground1 = HexColor.fromHex("#D3DAEA");
  static Color cAvatarBackground1 = HexColor.fromHex("#586789");
  static Color cardBackground2 = HexColor.fromHex("#F6DDCC");
  static Color cAvatarBackground2 = HexColor.fromHex("#DC7633");

  static const Color black = Colors.black;

  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 Char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
