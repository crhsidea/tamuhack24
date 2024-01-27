//job title
//how many hours

import 'package:flutter/material.dart';

class JobForm extends StatefulWidget {
  const JobForm({super.key});

  @override
  State<JobForm> createState() => JobFormState();
}

class JobFormState extends State<JobForm> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return (Form(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Colors.blue.shade600),
          child: Column(children: [
            Row(
              children: <Widget>[
                Text('Title'),
                Spacer(flex: 3),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Proccessing form information")));
                  }
                },
                child: const Text("Submit job"))
          ])),
    ));
  }
}
