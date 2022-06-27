import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:pokesteps/models/LoginPrefs.dart';
import 'package:pokesteps/screens/RootPage.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login/';
  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
          : _signupUser, //display the signup if the email is not saved (this means never registered)
      onSubmitAnimationCompleted: () { //when i complete signup or perform correct login
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs
            ?.setBool('logged', true); //variable to check if i'm logged (if i'm logged next time skip directly to RootPage)
        _toHomePage(context);
      },

      loginAfterSignUp: true, //login after signup

      hideForgotPasswordButton: true, //not showed recover password
      onRecoverPassword: _recoverPassword, //not showed recover password
      disableCustomPageTransformer: true, //avoid bug (#97) flutter_login github

      userType: LoginUserType.email, //email as user
      userValidator: (value) =>
          EmailValidator.validate(value!) ? null : "Please enter a valid email", //validate the email

      termsOfService: [ //defining terms of service to be accepted to use the app
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
    Navigator.of(context).pushReplacementNamed(RootPage.route); //go to RootPage without possibility to go back
  }

  Future<String?> _authUser(LoginData data) { //login check
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

  Future<String?> _signupUser(SignupData data) { //performing signup when correct
    print('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (data.name != null && data.password != null) {
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs!
            .setString('email', data.name!);
        Provider.of<LoginPrefs>(context, listen: false)
            .prefs!
            .setString('password', data.password!);
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) { //Not defined cause hidden
    return Future.delayed(loginTime).then((_) {
      return '';
    });
  }
}
