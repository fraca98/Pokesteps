import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pokesteps/notifiers/Identity_Notifier.dart';
import 'package:pokesteps/model/Identity.dart';
import 'package:pokesteps/screen/SignUpPage.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class LoginPage extends StatefulWidget {
  static const route = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true; // used for obscure or not password
  String? currentEmail;
  String? currentPassword;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  /*late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Check();
  }

  void Check() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    IdentityNotifier identityNotifier = Provider.of<IdentityNotifier>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            /*In BoxDecoration adding different color in background with different
            gradient */
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.4,
                  0.5,
                  0.6,
                  0.8,
                ],
                colors: [
                  Color.fromARGB(251, 250, 248, 248),
                  Color.fromARGB(255, 221, 220, 213),
                  Color.fromARGB(255, 179, 176, 175),
                  Color.fromARGB(255, 158, 156, 153),
                ],
              ),
            ),
            /*---------------------------------------------------------------------------------------------------------------------*/
            /*---------------------------------------------------------------------------------------------------------------------*/
            /*---------------------------------------------------------------------------------------------------------------------*/
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    /*Adding in the top of the screen the image of Pokesteps */
                    child: Image.asset(
                      'assets/images/pokesteps.jpg',
                      scale: 0.5,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ),
                  const Text(
                    'Sign in, thanks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /*----------------------First TextFormField for e-mail-----------------------------------------------------------------*/
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          TextFormField(
                            controller: _emailController,
                            validator: (value) => EmailValidator.validate(
                                    value!) // Use EmailValidator from the package install in pubspec.yaml
                                ? null
                                : "Please enter a valid email",
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              prefixIcon: const Icon(Icons.email),
                              suffixIcon: IconButton(
                                onPressed: _emailController.clear,
                                icon: Icon(Icons.clear),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onSaved: (value) {
                              currentEmail = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          /*----------------------Second TextFormField for password--------------------------------------------------------------*/
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              //return null;
                              if (value.length < 6) {
                                return 'Password length error';
                              }
                              int controllo = ControlMethodLoginPage(value);
                              if (controllo < 3) {
                                return 'Number of digits incorrect';
                              }
                              if (value.length - controllo < 3) {
                                return 'Number of letters incorrect';
                              }
                            },
                            maxLines: 1,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  icon: Icon(isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  }),
                              hintText: 'Enter your password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onSaved: (value) {
                              currentPassword = value;
                            },
                          ),
                          Divider(
                            thickness: 3.0,
                          ),
                          FlutterPwValidator(
                            controller: _passwordController,
                            minLength: 6,
                            uppercaseCharCount: 0,
                            numericCharCount: 3,
                            specialCharCount: 0,
                            normalCharCount: 3,
                            width: 400,
                            height: 100,
                            defaultColor: Colors.black87,
                            successColor: Color.fromARGB(255, 47, 0, 255),
                            failureColor: Color.fromARGB(255, 255, 17, 0),
                            onSuccess: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                      content: new Text(
                                          "Ok, the password is ok, you can go now, click on SIGN IN button")));
                            },
                            onFail: () {
                              print("NOT MATCHED");
                            },
                          ),
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          /*---------------------------------------------------------------------------------------------------------------------*/
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //String email = _emailController.text;

                              if (_formKey.currentState!.validate()) {
                                identityNotifier.addIdentity(
                                    Identity(currentEmail, currentPassword));
                                //logindata.setBool('login', false);
                                //logindata.setString('email', email);
                                Navigator.pushNamed(context, '/HomePage');
                              } else {
                                //Navigator.pushNamed(context, '/HomePage');
                                //return null;

                                showDialog(
                                  //barrierColor: Colors.greenAccent,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    elevation: 5.0,
                                    backgroundColor: Colors.yellowAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25)),
                                    title: Text('Attention !!!'),
                                    content: Text(
                                        'Email, password\nentered incorrectly'),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          //Put your code here which you want to execute on Yes button click.
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            /*---------------------------------------------------------------------------------------------------------------------*/

                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 15, 40, 15),
                              primary: Colors.red,
                              elevation: 3.0,
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/SignUpPage');
                            },
                            child: Text(
                              'Click here to sign up',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 0, 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          TermsPrivacy(context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

int ControlMethodLoginPage(String value) {
  int count = 0;
  List<String> parola = [];
  List<String> numeri = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  for (int i = 0; i < value.length; i++) {
    parola.add(value[i]);
  }

  for (int k = 0; k < numeri.length; k++) {
    for (int kk = 0; kk < parola.length; kk++) {
      if (numeri[k] == parola[kk]) {
        count++;
      } else {
        continue;
      }
    }
  }
  return count;
}

Widget TermsPrivacy(context) {
  return Column(
    children: [
      Text("By creating an account, you are agreeing to our\n"),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/TermsConditionsPage');
              },
              child: Text(
                "Terms & Conditions ",
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              )),
          Text("and "),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/PrivacyPolicyPage');
              },
              child: Text(
                "Privacy Policy! ",
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    ],
  );
}
