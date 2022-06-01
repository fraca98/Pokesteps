import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:pokesteps/model/IdentitySignUp.dart';
import 'package:pokesteps/notifiers/Identity_Notifier_SignUp.dart';
import 'package:pokesteps/screen/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  static const route = '/SignUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  /*RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }*/

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstPasswordController = TextEditingController();
  TextEditingController _secondPasswordController = TextEditingController();
  bool isObscure = true;
  bool isObscure1 = true;
  String? currentNameSignUp;
  String? currentSurnameSignUp;
  String? currentEmailSignUp;
  String? currentPasswordSignUp;

  @override
  Widget build(BuildContext context) {
    IdentityNotifierSignUp identityNotifierSignUp =
        Provider.of<IdentityNotifierSignUp>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign up, thanks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            child: TextFormField(
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your First Name';
                                }
                                return null;
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'First name',
                                prefixIcon: const Icon(Icons.person),
                                suffixIcon: IconButton(
                                  onPressed: _firstNameController.clear,
                                  icon: Icon(Icons.clear),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (value) {
                                currentNameSignUp = value;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            /*---------------------------------------------------------------------------------------------------------------------*/
                            child: TextFormField(
                              controller: _lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Last Name';
                                }
                                return null;
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Last name',
                                prefixIcon: const Icon(Icons.person),
                                suffixIcon: IconButton(
                                  onPressed: _lastNameController.clear,
                                  icon: Icon(Icons.clear),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (value) {
                                currentSurnameSignUp = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      TextFormField(
                        controller: _emailController,
                        validator: (value) => EmailValidator.validate(value!)
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
                          currentEmailSignUp = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      TextFormField(
                        controller: _firstPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } /*else {
                            //call function to check password
                            bool result = validatePassword(value);
                            if (result) {
                              // create account event
                              return null;
                            } else {
                              return " Password should contain Capital, small letter & Number & Special";
                            }
                          }*/
                          //return null;
                          if (value.length < 6) {
                            return 'Password length error';
                          }
                          int controllo = ControlMethodSignUpPage(value);
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
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      FlutterPwValidator(
                        controller: _firstPasswordController,
                        minLength: 6,
                        uppercaseCharCount: 0,
                        numericCharCount: 3,
                        specialCharCount: 0,
                        normalCharCount: 3,
                        width: 400,
                        height: 100,
                        defaultColor: Colors.black87,
                        onSuccess: () {
                          print("MATCHED");
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(
                                  content: new Text("Good password !!!")));
                        },
                        onFail: () {
                          print("NOT MATCHED");
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      TextFormField(
                        controller: _secondPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password again';
                          }

                          /*switch (_firstPasswordController.text !=
                              _secondPasswordController.text) {
                            case true:
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  elevation: 5.0,
                                  backgroundColor: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25)),
                                  title: Text('Attention !!!'),
                                  content: Text('Password incorrect'),
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
                              break;
                          }*/

                          if (_firstPasswordController.text !=
                              _secondPasswordController.text) {
                            return 'ATTENTION!!!!!  PASSWORD DO NOT MATCH';
                          }
                        },
                        maxLines: 1,
                        obscureText: isObscure1,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(isObscure1
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isObscure1 = !isObscure1;
                                });
                              }),
                          hintText: 'Enter your password to confirm',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSaved: (value) {
                          currentPasswordSignUp = value;
                        },
                      ),
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            identityNotifierSignUp.addIdentity(IdentitySignUp(
                                currentNameSignUp,
                                currentSurnameSignUp,
                                currentEmailSignUp,
                                currentPasswordSignUp));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          } else {
                            //Parentesi prima dell'else
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                elevation: 5.0,
                                backgroundColor: Colors.yellowAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25)),
                                title: Text('Attention !!!'),
                                content: Text('Some errors'),
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
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          primary: Colors.red,
                          elevation: 3.0,
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      /*---------------------------------------------------------------------------------------------------------------------*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already registered?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int ControlMethodSignUpPage(String value) {
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
