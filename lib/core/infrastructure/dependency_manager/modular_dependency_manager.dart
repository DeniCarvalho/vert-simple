import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/domain.dart';

///
/// Dependency manager implementation with Modular package
///
class ModularDependencyManager implements DependencyManager {
  ModularDependencyManager._();
  static ModularDependencyManager? _instance;

  ///
  /// Static instance for DM
  ///
  static ModularDependencyManager i() {
    _instance ??= ModularDependencyManager._();

    return _instance!;
  }

  @override
  T get<T extends Object>() {
    return Modular.get<T>();
  }
}
