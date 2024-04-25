import 'package:flutter/material.dart';

/// Width and Height mediaqueries
extension Size on BuildContext {
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;
}
