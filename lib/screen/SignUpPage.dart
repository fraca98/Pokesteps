import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
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
      body: Center(
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
                height: 60,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
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
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
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
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) {
                        currentEmailSignUp = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _firstPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
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
                    const SizedBox(
                      height: 20,
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
                                  borderRadius: new BorderRadius.circular(25)),
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
                      height: 20,
                    ),
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
    );
  }
}
