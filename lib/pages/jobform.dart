//job title
//how many hours
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flacktest/pages/navbar.dart';

class JobForm extends StatefulWidget {
  const JobForm({super.key});

  @override
  State<JobForm> createState() => JobFormState();
}

class JobFormState extends State<JobForm> {
  final titleController = TextEditingController();
  // ignore: non_constant_identifier_names
  final DescriptionController = TextEditingController();
  final hours = TextEditingController();
  // ignore: non_constant_identifier_names
  bool title = false;
  bool descript = false;
  bool hourse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Colors.blue.shade600),
          child: Column(children: [
            const Text("Write a title for your job!"),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: titleController,
                )),
            const Text('Put description here'),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: titleController,
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreenNav()));
                },
                child: const Text("Submit job")),
            // Container(const WidgetSpan(child: Icon(
            //   (title && descript && hours)? Icons.check: Icons.sentiment_dissatisfied,
            //   size: 14,
            //   color: (title && descript && hours)? Colors.green.shade600: Colors.red.shade300
            // )))
          ])),
    ));
  }
}
