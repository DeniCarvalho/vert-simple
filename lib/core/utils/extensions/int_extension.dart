extension IntExtension on int {
  String toZeroLeft(int width) => toString().padLeft(width, '0');
}