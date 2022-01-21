import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/domain.dart';

///
/// Navigation implementation using Modular package
///
class ModularNavigation implements Navigation {
  ModularNavigation._();
  static ModularNavigation? _instance;

  ///
  /// Static instance for DM
  ///
  static ModularNavigation i() {
    _instance ??= ModularNavigation._();
    return _instance!;
  }

  @override
  bool canPop() {
    return Modular.to.canPop();
  }

  @override
  void pop<T extends Object>({T? response}) {
    if (response != null) {
      Modular.to.pop(response);
    } else {
      Modular.to.pop();
    }
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String path, {
    Object? arguments,
    bool? forRoot,
  }) async {
    return Modular.to.pushNamed<T?>(
      path,
      arguments: arguments,
      forRoot: forRoot ?? false,
    );
  }

  @override
  Future<Object?> pushReplacementNamed(
    String path, {
    Object? arguments,
    bool? forRoot,
  }) {
    return Modular.to.pushReplacementNamed<dynamic, dynamic>(
      path,
      arguments: arguments,
      forRoot: forRoot ?? false,
    );
  }

  @override
  Future<void> navigate(String path, {dynamic arguments}) async {
    return Modular.to.navigate(path, arguments: arguments);
  }
}
