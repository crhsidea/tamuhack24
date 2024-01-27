import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {

  @override
  Widget build (BuildContext context) {
    return Scaffold(
			body: Center(
				child: Column(
					children: [
						const Text("Email"),
						const SizedBox(width: 100, height: 100, child: const Text("Todo")),
					]
				)
			)	
		);
  };
}
