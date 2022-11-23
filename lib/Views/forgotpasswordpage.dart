import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentTextStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                contentPadding: const EdgeInsets.all(20),
                content: const Text(
                  'Successfully sent!',
                ),
              ));

      emailController.clear();
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentTextStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
                actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                contentPadding: const EdgeInsets.all(20),
                content: Text(
                  e.message!,
                ),
                actions: [
                  TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Okay',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: [
            const Text(
              'Enter your email. We will send password reset link.',
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: const TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black),
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xff929292)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.5)),
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
              height: 40,
            ),
            ElevatedButton(
                onPressed: passwordReset,
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    fixedSize: MaterialStateProperty.all(const Size(167.5, 54)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))))),
          ]),
        ),
      ),
    );
  }
}
