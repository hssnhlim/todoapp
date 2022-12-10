import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authentication/auth.provider.dart';
import 'package:todoapp/authentication/register.dart';

import '../Views/forgotpasswordpage.dart';
import '../Views/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool obscureText = true;

  @override
  void initState() {
    // GetStorage().remove('firstTime');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool?> _onBackPressed() async {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titlePadding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
            actionsPadding:
                const EdgeInsets.only(right: 20, left: 20, top: 0, bottom: 20),
            title: const Text(
              'Do you really want to exit the app?',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  SystemNavigator.pop();
                  // exit(0);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      onWillPop: () async {
                        final warning = await _onBackPressed();
                        return warning ?? false;
                      },
                      key: _formKey,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Column(
                            children: [
                              FadeInLeft(
                                duration: const Duration(milliseconds: 1000),
                                delay: const Duration(milliseconds: 800),
                                child: Column(
                                  children: const [
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
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              FadeInUp(
                                duration: const Duration(milliseconds: 1000),
                                delay: const Duration(milliseconds: 1000),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.black),
                                      // The validator receives the text that the user has entered.
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_outlined,
                                            color: Colors.black),
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
                                                color: Colors.black,
                                                width: 2.5)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      obscureText: obscureText,
                                      style: const TextStyle(
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
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: Colors.black,
                                              )),
                                          prefixIcon: const Icon(
                                            Icons.password_outlined,
                                            color: Colors.black,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Enter Password',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Color(0xff929292)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.5)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1)),
                                          errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  style: BorderStyle.solid,
                                                  width: 2.5)),
                                          focusedErrorBorder:
                                              const OutlineInputBorder(
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPasswordPage()),
                                          );
                                        },
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                              fontFamily: 'poopins',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 43,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      delay: const Duration(milliseconds: 1000),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            // Validate returns true if the form is valid, or false otherwise.
                                            if (_formKey.currentState!
                                                .validate()) {
                                              try {
                                                setState(() {
                                                  loading = true;
                                                });
                                                await Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .login(
                                                        emailController.text
                                                            .trim(),
                                                        passwordController.text
                                                            .trim());
                                                if (!mounted) return;
                                                setState(() {
                                                  loading = false;
                                                });
                                                // Navigator.of(context).push(
                                                //     PageTransition(
                                                //         child: const HomePage(),
                                                //         type: PageTransitionType
                                                //             .rightToLeft,
                                                //         duration:
                                                //             const Duration(
                                                //                 milliseconds:
                                                //                     800),
                                                //         curve: Curves
                                                //             .easeInCubic));
                                              } on FirebaseAuthException catch (e) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              contentTextStyle: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 15),
                                                              actionsPadding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      20,
                                                                      10),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(20),
                                                              content: Text(
                                                                e.message!,
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    style: ButtonStyle(
                                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10))),
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(Colors
                                                                                .black)),
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child:
                                                                        const Text(
                                                                      'Okay',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              'poppins',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              15),
                                                                    ))
                                                              ],
                                                            ));
                                              }
                                            }
                                          },
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      const Size(0, 54)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          child: const Text(
                                            'Sign In',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                                letterSpacing: 1),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              const SizedBox(
                                height: 20,
                              ),
                              FadeInUp(
                                duration: const Duration(milliseconds: 1000),
                                delay: const Duration(milliseconds: 1000),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Don\'t have an account?',
                                        style: TextStyle(
                                          fontFamily: 'poopins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageTransition(
                                                child: const RegisterPage(),
                                                type: PageTransitionType
                                                    .topToBottom,
                                                childCurrent: const LoginPage(),
                                                duration: const Duration(
                                                    milliseconds: 800),
                                                curve: Curves.easeInCubic));
                                      },
                                      child: const Text(' Sign Up',
                                          style: TextStyle(
                                            fontFamily: 'poopins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          )),
                                    )
                                  ],
                                ),
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
