import 'package:flacktest/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

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
        resizeToAvoidBottomInset: true,
        /*appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Signup for JobJet"),
        ),*/
        body: SingleChildScrollView(
					child: Center(
            child: Column(children: [
					Padding(
						padding: EdgeInsets.only(top: 48.0, left: 32.0, bottom: 16.0),
						child: Align(
							alignment: Alignment.centerLeft,
							child: Text("Sign up", style: TextStyle(color: Color(0xFF065A82), fontWeight: FontWeight.bold, fontSize: 64.0)),
						),
					),
          Image(image: AssetImage("images/rocket_launch.gif")),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.check),
                hintText: 'Full Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              obscureText: true,
              obscuringCharacter: '●',
              controller: passwordController,
              onChanged: (text) {
                setState(() {
                  passOk = text.length >= 6;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password_outlined),
                hintText: 'Password',
              ),
            ),
          ),
          RichText(
              text: TextSpan(children: [
            WidgetSpan(
                child: Icon(
              passOk ? Icons.check : Icons.sentiment_dissatisfied,
              size: 14,
              color: passOk ? Colors.green : Colors.red,
            )),
            TextSpan(
              text: passOk
                  ? "Your password has at least 6 characters"
                  : "Your password must be 6 or more characters long",
              style: TextStyle(color: passOk ? Colors.green : Colors.red),
            )
          ])),
          SizedBox(height: 16),
          SizedBox(
            height: 42,
            width: 200,
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                child: const Text(
                  "Get started",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    final AuthResponse res = await supabase.auth.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    await supabase.from("profiles").update({
                      'username':
                          supabase.auth.currentUser!.email!.split("@")[0],
                      'full_name': nameController.text
                    }).match({'id': supabase.auth.currentUser?.id});

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
                                Text('There was an error signing you up:'),
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
                }),
          )
        ]))));
  }
}
