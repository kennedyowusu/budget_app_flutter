import 'package:flutter/material.dart';

Map<String, double> calculateResponsiveValues(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final double verticalSpacing = screenSize.height * 0.03;
  final double horizontalSpacing = screenSize.width * 0.05;
  final double titleFontSize = screenSize.width * 0.06;
  final double textFieldHeight = screenSize.height * 0.07;
  final double buttonHeight = screenSize.height * 0.08;
  final double bottomSheetHeight = screenSize.height * 0.09;
  final double containerHeight = screenSize.height * 0.10;

  return {
    'verticalSpacing': verticalSpacing,
    'horizontalSpacing': horizontalSpacing,
    'titleFontSize': titleFontSize,
    'textFieldHeight': textFieldHeight,
    'buttonHeight': buttonHeight,
    'bottomSheetHeight': bottomSheetHeight,
    'containerHeight': containerHeight,
  };
}
