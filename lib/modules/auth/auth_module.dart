library auth_module;

import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/auth_routes.dart';
import 'presentation/presentation.dart';

///
/// Auth module definition
///
class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AuthRoutes.login,
      child: (_, __) => const LoginPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
