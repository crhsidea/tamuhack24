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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sign in JobJet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  hintText: 'enter Email',
                  fillColor: Color(0xFFE6E1C5),
                  focusColor: Color(0xFFBA2D0B),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xFFBA2D0B))),
                ),
                controller: emailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: 'enter Email',
                    fillColor: Color(0xFFE6E1C5),
                    focusColor: Color(0xFFBA2D0B),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xFFBA2D0B))),
                  ),
                  controller: passwordController,
                  onChanged: (text) {
                    setState(() {
                      passOk = text.length >= 6;
                    });
                  }),
            ),
            SizedBox(
              height: 42,
              width: 200,
              child: TextButton(
                child: const Text(
                  "Get started",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.lightBlue),
                ),
                onPressed: () async {
                  try {
                    final AuthResponse res =
                        await supabase.auth.signInWithPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreenNav()));
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
