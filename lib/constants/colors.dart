import 'package:flutter/material.dart';

class SphereShopColors {
  static Color _getColorFromHex(String hexColor) {
    final String colorString = hexColor.replaceAll("#", "");
    return Color(int.parse("0xFF$colorString"));
  }

  static Color white = _getColorFromHex("FFFFFF");
  static Color primaryColor = _getColorFromHex("667080");
  static Color primaryColorDark = _getColorFromHex("393F48");
  static Color secondaryColor = _getColorFromHex("EEF1F4");
  static Color secondaryColorDark = _getColorFromHex("C3C6C9");
}
