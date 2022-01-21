import 'package:flutter/material.dart';

/// PostFrameMixin
mixin PostFrameMixin<T extends StatefulWidget> on State<T> {
  /// postFrame
  void postFrame(void Function() callback) =>
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) {
          if (mounted) callback();
        },
      );
}
