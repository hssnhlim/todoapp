import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/homepage.dart';
import 'package:todoapp/Views/profilePage.dart';

import '../authentication/auth.provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // bool snackBar = false;

  Future<void> saveEditProfile() async {
    // form textfield error if empty
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     await Provider.of<AuthProvider>(context, listen: false)
    //         .updateProfileName(nameController.text.trim());
    //     await Provider.of<AuthProvider>(context, listen: false)
    //         .updateProfileEmail(emailController.text.trim());
    //   } on FirebaseAuthException catch (e) {
    //     return showDialog(
    //         useSafeArea: true,
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10)),
    //             titlePadding: const EdgeInsets.only(
    //                 top: 30, left: 20, right: 20, bottom: 20),
    //             actionsPadding: const EdgeInsets.only(
    //                 right: 20, left: 20, top: 0, bottom: 20),
    //             title: Text(
    //               e.message!,
    //               style: const TextStyle(
    //                 fontFamily: 'poppins',
    //                 fontWeight: FontWeight.w400,
    //                 fontSize: 18,
    //               ),
    //             ),
    //             actions: [
    //               MaterialButton(
    //                 color: Colors.black,
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text(
    //                   'Yes',
    //                   style: TextStyle(
    //                       fontFamily: 'poppins',
    //                       fontWeight: FontWeight.w400,
    //                       fontSize: 15,
    //                       color: Colors.white),
    //                 ),
    //               )
    //             ],
    //           );
    //         });
    //   }
    // }
    // Navigator.of(context).pop();
    if (nameController.text.isNotEmpty) {
      setState(() {
        Provider.of<AuthProvider>(context, listen: false)
            .updateProfileName(nameController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Name Updated!',
          style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
        )));
      });
    } else if (emailController.text.isNotEmpty) {
      setState(() {
        Provider.of<AuthProvider>(context, listen: false)
            .updateProfileEmail(emailController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Email updated!',
          style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
        )));
      });
    } else if (nameController.text.isEmpty || emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Please fill the text field!',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));
    } else {
      return;
    }

    // Navigator.of(context).pop();
  }

  Future<bool?> onBackButton() async {
    if (nameController.text.isNotEmpty || emailController.text.isNotEmpty) {
      return showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              titlePadding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 20),
              actionsPadding: const EdgeInsets.only(
                  right: 20, left: 20, top: 0, bottom: 20),
              title: const Text(
                'Discard changes?',
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
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                  // exit(0);

                  child: const Text(
                    'Discard',
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
    } else {
      Navigator.pop(context);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: onBackButton, icon: const Icon(Icons.arrow_back)),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Edit Profile',
              style:
                  TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
              maxLines: 1,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    textField(
                      nameController,
                      user!.displayName,
                      const Icon(Icons.person_outline, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(emailController, user.email,
                        const Icon(Icons.email_outlined, color: Colors.black)),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(child: saveButton('Save', saveEditProfile))
                      ],
                    )
                  ],
                ))),
      ),
    );
  }
}

Widget textField(controller, hintText, icon) {
  return TextFormField(
    cursorColor: Colors.black,
    style: const TextStyle(
        fontFamily: 'poppins',
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: Colors.black),
    // The validator receives the text that the user has entered.
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: icon,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Color(0xff929292)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, style: BorderStyle.solid, width: 1)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, style: BorderStyle.solid, width: 1))),
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please fill the text field!';
      }
      return null;
    },
  );
}

Widget saveButton(text, saveEditProfile) {
  return ElevatedButton(
      onPressed: saveEditProfile,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          fixedSize: MaterialStateProperty.all(const Size(0, 54)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20,
            letterSpacing: 1),
      ));
}