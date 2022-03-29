import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rive/rive.dart';

import '../../../../../core/core.dart';
import '../../presentation.dart';

///
/// Custom splash page
///
class SplashPage extends StatefulWidget {
  /// Creates a [SplashPage]
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with PostFrameMixin {
  late bool showLogo = false;
  late bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    postFrame(_navigateAfterStart);
  }

  Future<void> _navigateAfterStart() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() => showLogo = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => startAnimation = true);

    await Future.delayed(const Duration(milliseconds: 500));
    Nav.navigate(SplashRoutes.home);
    SystemChrome.restoreSystemUIOverlays();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init().config(constraints, orientation);
            return Scaffold(
              backgroundColor: AppColors.light,
              body: Stack(
                children: [
                  if (!startAnimation)
                    Center(
                      child: SizedBox(
                        height: !kIsWeb ? 50.responsiveHeight : 50,
                        child: RiveAnimation.asset(
                          AppAnimations.logo,
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: LogoComponent(
                      height: !kIsWeb ? 44.responsiveHeight : 50,
                      isHero: !kIsWeb,
                      color: startAnimation ? null : AppColors.transparent,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
