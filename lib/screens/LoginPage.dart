import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/models/LoginPrefs.dart';
import 'package:pokesteps/screens/RootPage.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  static const route = '/';
  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _firstPasswordController = TextEditingController();

  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: AssetImage('assets/images/pokesteps.png'),
      onLogin: _authUser,
      onSignup: Provider.of<LoginPrefs>(context, listen: false)
                  .prefs
                  ?.getString('email') !=
              null
          ? null
          : _signupUser,
      onSubmitAnimationCompleted: () {
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs
            ?.setBool('logged', true);
        _toHomePage(context);
      },

      loginAfterSignUp: true,

      hideForgotPasswordButton: true,
      onRecoverPassword: _recoverPassword, //not showed recover password

      userType: LoginUserType.email,
      userValidator: (value) =>
          EmailValidator.validate(value!) ? null : "Please enter a valid email",

      termsOfService: [
        TermOfService(
            id: 'privacy',
            mandatory: true,
            text: 'Privacy policy',
            linkUrl:
                'http://htmlpreview.github.io/?https://github.com/fraca98/TermsPokesteps/blob/main/Privacypolicy.html'),
        TermOfService(
            id: 'termsandconditions',
            mandatory: true,
            text: 'Terms and conditions',
            linkUrl:
                'http://htmlpreview.github.io/?https://github.com/fraca98/TermsPokesteps/blob/main/TermsandConditions.html'),
      ],

      theme: LoginTheme(
        logoWidth: 1.2,
        primaryColor: Colors.red,
        accentColor: Colors.white,
        errorColor: Colors.red,
        cardTheme: CardTheme(
          color: Colors.white,
        ),
      ),
    );
  }

  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RootPage.route);
  } //_toHomePage

  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (data.name !=
          Provider.of<LoginPrefs>(context, listen: false)
              .prefs!
              .getString('email')) {
        return 'User not exists';
      }
      if (data.password !=
          Provider.of<LoginPrefs>(context, listen: false)
              .prefs!
              .getString('password')) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    print('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (data.name != null && data.password != null) {
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs!
            .setString('email', data.name!);
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs!
            .setString('password', data.password!);
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs!
            .setBool('logged', true);
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return '';
    });
  }
}
