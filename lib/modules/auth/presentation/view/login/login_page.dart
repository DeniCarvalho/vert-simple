import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../../core/core.dart';
import '../../../../../internationalization/i18n_extension.dart';
import '../../presentation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passController;
  final FocusNode _passFocus = FocusNode();
  late bool _loading = false;
  late bool _loading365 = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  void signin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      Nav.navigate(AuthRoutes.homeModule);
      setState(() => _loading = false);
    }
  }

  void signin365() async {
    setState(() => _loading365 = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _loading365 = false);
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: deviceType == DeviceScreenType.mobile
          ? AppColors.light
          : const Color(0xfff2f2f2),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: deviceType == DeviceScreenType.mobile
            ? EdgeInsets.symmetric(
                vertical: 40.responsiveHeight,
                horizontal: 20.responsiveWidth,
              )
            : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: ScreenTypeLayout(
                mobile: _form(),
                desktop: _desktop,
                tablet: _desktop,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _desktop => SizedBox(
        width: 400,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: _form(isMobile: false),
          ),
        ),
      );

  Widget _form({bool isMobile = true}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LogoComponent(
          height: isMobile ? 44.responsiveHeight : 30,
          isHero: !kIsWeb,
        ),
        SizedBox(
          height: isMobile ? 10.responsiveHeight : 10,
        ),
        Text(
          'DTVM',
          style: TextStyle(
            color: AppColors.secundary,
            fontSize: isMobile ? 20.responsiveWidth : 14,
          ),
        ),
        SizedBox(
          height: isMobile ? 40.responsiveHeight : 25,
        ),
        TextFieldComponent(
          controller: _emailController,
          placeholder: 'email'.i18n(context),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          contentPadding: isMobile
              ? null
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          onFieldSubmitted: (val) {
            FocusScope.of(context).requestFocus(_passFocus);
          },
          validator: (val) {
            if (val == null || val.isEmpty) return 'Campo obrigatório';

            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val);
            if (!emailValid) return 'invalidEmail'.i18n(context);

            return null;
          },
        ),
        SizedBox(
          height: isMobile ? 25.responsiveHeight : 20,
        ),
        TextFieldComponent(
          controller: _passController,
          placeholder: 'password'.i18n(context),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          focusNode: _passFocus,
          contentPadding: isMobile
              ? null
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          onFieldSubmitted: (val) {
            signin();
          },
          validator: (val) {
            if (val == null || val.isEmpty) return 'required'.i18n(context);

            return null;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OnHover(builder: (isHovered) {
              return TextButton(
                onPressed: () {},
                child: Text(
                  'forgotYourPassword'.i18n(context),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.transparent),
                  foregroundColor: isHovered
                      ? MaterialStateProperty.all(AppColors.primary)
                      : MaterialStateProperty.all(AppColors.system),
                ),
              );
            }),
          ],
        ),
        SizedBox(
          height: isMobile ? 15.responsiveHeight : 15,
        ),
        ButtonComponent(
          text: 'signIn'.i18n(context),
          onPressed: signin,
          loading: _loading,
          enabled: !_loading,
          fontSize: isMobile ? null : 15,
          padding: isMobile && !kIsWeb
              ? null
              : MaterialStateProperty.all(
                  const EdgeInsets.all(20),
                ),
        ),
        Container(
          color: AppColors.system.withOpacity(0.15),
          height: isMobile ? 2.5.responsiveHeight : 2.5,
          margin: EdgeInsets.symmetric(
            vertical: isMobile ? 30.responsiveHeight : 15,
          ),
        ),
        Text(
          'accessWith'.i18n(context),
          style: GoogleFonts.lato(
            color: AppColors.secundary,
            fontSize: isMobile ? 17.fontSize : 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: isMobile ? 30.responsiveHeight : 15,
        ),
        OnHover(builder: (isHovered) {
          return ButtonComponent(
            onPressed: signin365,
            loading: _loading365,
            enabled: !_loading365,
            colorLoading: const Color(0xffeb3c00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.microsoft365,
                  height: isMobile ? 18.responsiveHeight : 18,
                  fit: BoxFit.contain,
                  color: isHovered ? AppColors.light : null,
                ),
                SizedBox(
                  width: 5.responsiveWidth,
                ),
                Text(
                  'office365'.i18n(context),
                  style: GoogleFonts.lato(
                    fontSize: isMobile ? 18.fontSize : 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            style: ButtonStyle(
              alignment: Alignment.center,
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(
                    color: AppColors.danger,
                  ),
                ),
              ),
              padding: isMobile && !kIsWeb
                  ? MaterialStateProperty.all(
                      const EdgeInsets.all(12),
                    )
                  : MaterialStateProperty.all(
                      const EdgeInsets.all(20),
                    ),
              backgroundColor: !isHovered
                  ? MaterialStateProperty.all(AppColors.light)
                  : MaterialStateProperty.all(const Color(0xffeb3c00)),
              foregroundColor: isHovered
                  ? MaterialStateProperty.all(AppColors.light)
                  : MaterialStateProperty.all(const Color(0xffeb3c00)),
              elevation: MaterialStateProperty.all(4),
            ),
          );
        }),
      ],
    );
  }
}
