///
/// Utility class to manage dependencies
///
// ignore: one_member_abstracts
abstract class DependencyManager {
  ///
  /// Get an instance of type T from the DM
  ///
  T get<T extends Object>();
}
