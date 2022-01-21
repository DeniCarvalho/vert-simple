library home_module;

import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/home_routes.dart';
import 'presentation/presentation.dart';

///
/// Home module definition
///
class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      HomeRoutes.home,
      child: (_, __) => const HomePage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
