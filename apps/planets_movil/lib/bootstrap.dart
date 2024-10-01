// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `AppProviderObserver` es una implementación de `ProviderObserver`
/// que permite observar y registrar eventos relacionados con los proveedores
/// de Riverpod, como actualizaciones de estado y errores.
///
/// Esta clase puede ser utilizada para el seguimiento y la depuración
/// de los cambios en los valores de los proveedores durante la ejecución
/// de la aplicación.
class AppProviderObserver extends ProviderObserver {
  static const String _providerUpdatedMessage = 'Provider: {} updated. New value: {}';
  static const String _providerErrorMessage = 'Provider: {} error: {}';

  /// Método que se llama cuando un proveedor se actualiza.
  ///
  /// - `provider`: El proveedor que ha sido actualizado.
  /// - `previousValue`: El valor anterior del proveedor.
  /// - `newValue`: El nuevo valor del proveedor.
  /// - `container`: El contenedor del proveedor en el que se encuentra.
  ///
  /// Este método registra un mensaje en el registro de la aplicación que
  /// indica qué proveedor se ha actualizado y cuál es su nuevo valor.
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final providerName = provider.name ?? provider.runtimeType.toString();
    log(
      _providerUpdatedMessage
          .replaceFirst('{}', providerName)
          .replaceFirst('{}', newValue.toString()),
    );
  }

  /// Método que se llama cuando ocurre un error en un proveedor.
  ///
  /// - `provider`: El proveedor que ha generado un error.
  /// - `error`: El objeto de error que se ha producido.
  /// - `stackTrace`: La traza de la pila asociada al error.
  /// - `container`: El contenedor del proveedor en el que se encuentra.
  ///
  /// Este método registra un mensaje en el registro de la aplicación que
  /// indica qué proveedor ha generado un error y qué error ha ocurrido.
  void onProviderError(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final providerName = provider.name ?? provider.runtimeType.toString();
    log(
      _providerErrorMessage
          .replaceFirst('{}', providerName)
          .replaceFirst('{}', error.toString()),
    );
  }
}
