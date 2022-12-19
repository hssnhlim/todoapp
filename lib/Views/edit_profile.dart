import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/user.model.dart';

import '../authentication/auth.provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> saveEditProfile() async {
    var uid =
        await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();
    final docTL = FirebaseFirestore.instance.collection('users').doc(uid);

    if (nameController.text.trim().isNotEmpty) {
      await docTL.update({'name': nameController.text.trim()});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Saved!',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));

      Navigator.of(context).pop();
    } else if (emailController.text.trim().isNotEmpty) {
      await docTL.update({'email': emailController.text.trim()});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Changes saved!',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));

      Navigator.of(context).pop();
    } else if (phoneController.text.trim().isNotEmpty) {
      await docTL.update({'phone': phoneController.text.trim()});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Changes saved!',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));

      Navigator.of(context).pop();
    } else if (nameController.text.isEmpty || emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Please fill the text field!',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
      )));
    } else {
      return;
    }
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

    return null;
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
                      'Name',
                      const Icon(Icons.person_outline, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(emailController, 'Email',
                        const Icon(Icons.email_outlined, color: Colors.black)),
                    const SizedBox(
                      height: 20,
                    ),
                    textFieldPhone(phoneController, 'Phone Number',
                        const Icon(Icons.phone_outlined, color: Colors.black)),
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

Widget textFieldPhone(controller, hintText, icon) {
  return TextFormField(
    keyboardType: TextInputType.phone,
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
