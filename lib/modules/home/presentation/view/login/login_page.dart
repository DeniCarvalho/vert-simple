import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vert_simple/core/core.dart';

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
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
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
    return Scaffold(
      backgroundColor: AppColors.light,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: 40.responsiveHeight,
            horizontal: 20.responsiveWidth,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      LogoComponent(
                        height: 44.responsiveHeight,
                        isHero: true,
                      ),
                      SizedBox(
                        height: 10.responsiveHeight,
                      ),
                      AnimatedTextKit(
                        isRepeatingAnimation: false,
                        totalRepeatCount: 0,
                        animatedTexts: [
                          TyperAnimatedText(
                            'DTVM',
                            textStyle: TextStyle(
                              color: AppColors.secundary,
                              fontSize: 20.responsiveWidth,
                            ),
                            speed: const Duration(milliseconds: 50),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.responsiveHeight,
                ),
                TextFieldComponent(
                  controller: _emailController,
                  placeholder: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(_passFocus);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Campo obrigatório';

                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val);
                    if (!emailValid) return 'E-mail inválido';

                    return null;
                  },
                ),
                SizedBox(
                  height: 25.responsiveHeight,
                ),
                TextFieldComponent(
                  controller: _passController,
                  placeholder: 'Senha',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  focusNode: _passFocus,
                  onFieldSubmitted: (val) {
                    signin();
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Campo obrigatório';

                    return null;
                  },
                ),
                SizedBox(
                  height: 40.responsiveHeight,
                ),
                ButtonComponent(
                  text: 'Entrar',
                  onPressed: signin,
                  loading: _loading,
                  enabled: !_loading,
                ),
                Container(
                  color: AppColors.system.withOpacity(0.15),
                  height: 2.5.responsiveHeight,
                  margin: EdgeInsets.symmetric(
                    vertical: 30.responsiveHeight,
                  ),
                ),
                Text(
                  'Ou acesse com',
                  style: GoogleFonts.lato(
                    color: AppColors.secundary,
                    fontSize: 17.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 30.responsiveHeight,
                ),
                ButtonComponent(
                  onPressed: signin365,
                  loading: _loading365,
                  enabled: !_loading365,
                  colorLoading: const Color(0xffeb3c00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.microsoft365,
                        height: 18.responsiveHeight,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 5.responsiveWidth,
                      ),
                      Text(
                        'Office 365',
                        style: GoogleFonts.lato(
                          fontSize: 18.fontSize,
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
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(12.responsiveWidth),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColors.light),
                    foregroundColor:
                        MaterialStateProperty.all(const Color(0xffeb3c00)),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xffeb3c00).withOpacity(0.2)),
                    elevation: MaterialStateProperty.all(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
