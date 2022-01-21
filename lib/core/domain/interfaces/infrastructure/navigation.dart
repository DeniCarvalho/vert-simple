///
/// Interface for navigation
///
abstract class Navigation {
  ///
  /// Push a named route to the stack
  ///
  Future<T?> pushNamed<T extends Object?>(
    String path, {
    Object? arguments,
    bool? forRoot,
  });

  ///
  /// Push and replace a named route
  ///
  Future<Object?> pushReplacementNamed(
    String path, {
    Object? arguments,
    bool? forRoot,
  });

  ///
  /// Removes all previous routes and navigate to a route.
  ///
  void navigate(String path, {dynamic arguments});

  ///
  /// Pop the current route out of the stack
  ///
  void pop<T extends Object>({T? response});

  ///
  /// Return true if route can pop
  ///
  bool canPop();
}
