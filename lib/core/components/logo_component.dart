import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class LogoComponent extends StatelessWidget {
  final double height;
  final double top;
  final bool isHero;
  final bool transitionOnUserGestures;
  final bool isDark;
  final Color? color;
  const LogoComponent({
    Key? key,
    this.height = 50,
    this.top = 0,
    this.isHero = true,
    this.transitionOnUserGestures = true,
    this.isDark = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetName = isDark ? AppImages.logoLight : AppImages.logo;
    SvgPicture logo = SvgPicture.asset(
      assetName,
      height: height.responsiveHeight,
      fit: BoxFit.contain,
      color: color,
    );
    return Container(
      padding: EdgeInsets.only(top: top.responsiveHeight),
      child: isHero
          ? Hero(
              tag: "logo",
              transitionOnUserGestures: transitionOnUserGestures,
              child: logo,
            )
          : logo,
    );
  }
}
