///
/// Routes used for Auth
///
class AuthRoutes {
  ///
  /// Auth module route
  ///
  static const String module = '/auth';

  ///
  /// Home module route
  ///
  static const String homeModule = '/home/';

  ///
  /// Login route
  ///
  static const String login = '/login';
}

///
/// String extension to get auth children's routes
///
extension AuthRoutesExtension on String {
  /// Get complete auth child route path
  String get asAuthChild {
    return "${AuthRoutes.module}$this";
  }
}
