import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pokesteps/notifiers/Identity_Notifier.dart';
import 'package:pokesteps/model/Identity.dart';
import 'package:pokesteps/screen/SignUpPage.dart';

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
  TextEditingController _firstController = TextEditingController();
  TextEditingController _secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    IdentityNotifier identityNotifier = Provider.of<IdentityNotifier>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
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
                        /*First TextFormField for e-mail*/
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _firstController,
                          validator: (value) => EmailValidator.validate(
                                  value!) // Use EmailValidator from the package install in pubspec.yaml
                              ? null
                              : "Please enter a valid email",
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(
                                Icons.email), //Image of the email icon
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
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: _secondController,
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
                          onSaved: (value) {
                            currentPassword = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              identityNotifier.addIdentity(
                                  Identity(currentEmail, currentPassword));
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
                                      'Email and password\nentered incorrectly'),
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
                      ],
                    ),
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
