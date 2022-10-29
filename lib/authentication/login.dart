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
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log In'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(hintText: 'Enter Email'),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(hintText: 'Enter Password'),
                controller: passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .login(emailController.text, passController.text);
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('LOGIN'))
            ],
          ),
        ));
  }
}
