import 'package:flutter/material.dart';

/// Esta clase extiende el contexto para obtener dimensiones responsivas.
extension DimensExtension on BuildContext {
  
  /// Ancho total de la pantalla.
  double width([double? value]) {
    final screenWidth = MediaQuery.of(this).size.width;
    if (value != null) {
      return screenWidth * value;
    }
    return screenWidth;
  }

  /// Alto total de la pantalla.
  double height([double? value]) {
    final screenHeight = MediaQuery.of(this).size.height;
    if (value != null) {
      return screenHeight * value;
    }
    return screenHeight;
  }

  /// Retorna el tamaño de la pantalla, puede ser un porcentaje del ancho o alto.
  Size get screenSize => MediaQuery.of(this).size;

  /// Retorna el alto de la barra de estado.
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Retorna el alto de la barra de navegación.
  double get bottomNavigationBarHeight => kBottomNavigationBarHeight;

  /// Retorna un EdgeInsets calculado con el ancho de la pantalla.
  EdgeInsets fromLTRB({double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.fromLTRB(
      width(left),
      height(top),
      width(right),
      height(bottom),
    );
  }

  /// Retorna un EdgeInsets simétrico calculado con el ancho de la pantalla.
  EdgeInsets symmetric(double horizontal, double vertical) {
    return EdgeInsets.symmetric(
      vertical: height(vertical),
      horizontal: width(horizontal),
    );
  }

  /// Retorna un EdgeInsets con todos los lados iguales.
  EdgeInsets all(double value) => EdgeInsets.all(width(value));

  /// Retorna un EdgeInsets horizontal.
  EdgeInsets horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: width(value));

  /// Retorna un EdgeInsets vertical.
  EdgeInsets vertical(double value) =>
      EdgeInsets.symmetric(vertical: height(value));

  /// Retorna un EdgeInsets con valor en la parte superior.
  EdgeInsets top(double value) => EdgeInsets.only(top: height(value));

  /// Retorna un EdgeInsets con valor a la izquierda.
  EdgeInsets left(double value) => EdgeInsets.only(left: width(value));

  /// Retorna un EdgeInsets con valor a la derecha.
  EdgeInsets right(double value) => EdgeInsets.only(right: width(value));

  /// Retorna un EdgeInsets con valor en la parte inferior.
  EdgeInsets bottom(double value) => EdgeInsets.only(bottom: height(value));

  /// Calcula el padding de acuerdo a la orientación de la pantalla.
  EdgeInsets get responsivePadding {
    return EdgeInsets.all(width(0.05)); // Por ejemplo, un padding del 5%
  }

  /// Calcula el tamaño de fuente basado en la anchura de la pantalla.
  double fontSize(double value) {
    return width(value); // Un tamaño de fuente basado en el ancho
  }

  /// Calcula el tamaño de fuente basado en la altura de la pantalla.
  double fontSizeHeight(double value) {
    return height(value); // Un tamaño de fuente basado en la altura
  }

  /// Breakpoints para definir tamaños de dispositivos.
  static const double mobileBreakpoint = 767;
  static const double tabletBreakpoint = 1024;

  /// Retorna el tipo de dispositivo basado en el ancho de la pantalla.
  DeviceType get deviceType {
    final screenWidth = width();
    if (screenWidth <= mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (screenWidth <= tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
}

/// Tipos de dispositivos basados en *breakpoints*.
enum DeviceType { mobile, tablet, desktop }
