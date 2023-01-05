import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:io';

double getWidthPercent(BuildContext context, int percent) {
  return MediaQuery.of(context).size.width * (percent / 100);
}

double getHeightPercent(BuildContext context, int percent) {
  return MediaQuery.of(context).size.height * (percent / 100);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Future<bool> isOnline() async {
  try {
    final result = await InternetAddress.lookup('ecampus.ncfu.ru');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }else{
      return false;
    }
  } on SocketException catch (error) {
    log(error.toString());
    return false;
  }
}