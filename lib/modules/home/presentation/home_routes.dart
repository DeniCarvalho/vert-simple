///
/// Routes used for Home
///
class HomeRoutes {
  ///
  /// Home module route
  ///
  static const String module = '/home';

  ///
  /// Home route
  ///
  static const String home = '/';
}

///
/// String extension to get home children's routes
///
extension HomeRoutesExtension on String {
  /// Get complete home child route path
  String get asHomeChild {
    return "${HomeRoutes.module}$this";
  }
}
