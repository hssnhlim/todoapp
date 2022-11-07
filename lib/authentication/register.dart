import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/homepage.dart';
import 'package:todoapp/authentication/login.dart';

import 'auth.provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;

  Future addUserDetails(String name, String email, String phone) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'phone': phone,
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Sign Up',
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
                          'Sign up now to list all your important tasks',
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
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                          // The validator receives the text that the user has entered.
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.red[400]),
                            prefixIcon:
                                Icon(Icons.person_outline, color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xff929292)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.5)),
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
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name!';
                            }
                            if (value.length < 3) {
                              return 'Please enter at least 3 characters!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                          // The validator receives the text that the user has entered.
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.red[400]),
                            prefixIcon:
                                Icon(Icons.email_outlined, color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xff929292)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.5)),
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
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                          // The validator receives the text that the user has entered.
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.red[400]),
                            prefixIcon:
                                Icon(Icons.phone_outlined, color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Digit only and without space',
                            hintStyle: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xff929292)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.5)),
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
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number!';
                            }

                            Pattern pattern = r'(^(01)[0-46-9]*[0-9]{7,8}$)';
                            RegExp regex = RegExp(pattern.toString());

                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid phone number';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: obscureText,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black),
                          // The validator receives the text that the user has entered.
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Icon(
                                    obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black,
                                  )),
                              errorStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: Colors.red[400]),
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff929292)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.5)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.5)),
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
                            if (value.length < 6) {
                              return 'Please enter at least 6 characters!';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 53,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .register(
                                    nameController.text.trim(),
                                    emailController.text.trim(),
                                    phoneController.text.trim(),
                                    passwordController.text.trim(),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  );

                                  addUserDetails(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      phoneController.text.trim());
                                } on FirebaseAuthException catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            contentTextStyle: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                            actionsPadding:
                                                const EdgeInsets.fromLTRB(
                                                    0, 0, 20, 10),
                                            contentPadding:
                                                const EdgeInsets.all(20),
                                            content: Text(
                                              e.message!,
                                            ),
                                            actions: [
                                              TextButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .black)),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Okay',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ));
                                }
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  letterSpacing: 1),
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                fixedSize:
                                    MaterialStateProperty.all(Size(335, 54)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))))),
                        Expanded(child: Container()),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: TextStyle(
                                  fontFamily: 'poopins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Text(' Sign In',
                                  style: TextStyle(
                                    fontFamily: 'poopins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
