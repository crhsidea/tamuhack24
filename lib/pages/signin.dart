import 'package:flacktest/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SigninPage extends StatefulWidget {
  @override
  State<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passOk = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sign in JobJet"),
        ),
        body: Center(
            child: Column(children: [
          const Text("Email"),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Color(0xFFE6E1C5),
                focusColor: Color(0xFFBA2D0B),
              ),
              controller: emailController,
            ),
          ),
          const Text("Password"),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
                controller: passwordController,
                onChanged: (text) {
                  setState(() {
                    passOk = text.length >= 6;
                  });
                }),
          ),
          TextButton(
              child: const Text("Get started"),
              onPressed: () async {
                try {
                  final AuthResponse res =
                      await supabase.auth.signInWithPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreenNav()));
                } on AuthException catch (e) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Login error!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('There was an error signing you in:'),
                              Text(e.message),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              })
        ])));
  }
}
