import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authentication/auth.provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF3F3F3),
        // appBar: AppBar(
        //   title: const Text('Log In'),
        // ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sign in now to list all your important tasks',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xff929292)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.5)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2.5)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2.5)),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff929292)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.5)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 2.5)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 2.5))),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontFamily: 'poopins',
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .login(emailController.text,
                                    passwordController.text);
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message!)),
                            );
                          }
                        }
                      },
                      child: const Text('LOGIN')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: TextStyle(
                            fontFamily: 'poopins',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          )),
                      Text(' Sign Up',
                          style: TextStyle(
                            fontFamily: 'poopins',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
