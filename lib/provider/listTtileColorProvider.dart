import 'dart:ui';

import 'package:flutter/foundation.dart';

class ColorProvider extends ChangeNotifier {
  Color color;

  void getColor() => color;

  void setColor(Color color) => {this.color = color, notifyListeners()};
}
