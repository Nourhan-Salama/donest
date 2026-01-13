import 'package:flutter/material.dart';
extension ResponsiveExtension  on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // get icon size 
  double get iconSize {
    if (isMobile) return 16;
    if (isTablet) return 22;
    return 28; // Desktop
  }

    // 🔥 Spacing scaler
  double space(double value) {
    if (isMobile) return value;
    if (isTablet) return value * 1.4;
    return value * 1.8;
  }


  // Responsive font size
  double responsiveFont(double baseSize) {
    if (isMobile) return baseSize;
    if (isTablet) return baseSize * 1.3;
    return baseSize * 1.6; // desktop
  }

}