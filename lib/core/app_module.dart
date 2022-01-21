import 'package:flutter_modular/flutter_modular.dart';

import '../modules/auth/presentation/presentation.dart';
import '../modules/home/presentation/home_routes.dart';
import '../modules/modules.dart';
import '../modules/splash/presentation/presentation.dart';

///
/// Base app module definition
///
class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const SplashPage(),
    ),
    ModuleRoute(
      AuthRoutes.module,
      module: AuthModule(),
    ),
    ModuleRoute(
      HomeRoutes.module,
      module: HomeModule(),
    ),
  ];
}
