//job title
//how many hours
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flacktest/pages/navbar.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class JobForm extends StatefulWidget {
  JobForm(
      {super.key,
      required this.title1,
      required this.descript1,
      required this.hours1});
  String title1;
  String descript1;
  String hours1;

  @override
  State<JobForm> createState() => JobFormState();
}

class JobFormState extends State<JobForm> {
  final titleController = TextEditingController();
  // ignore: non_constant_identifier_names
  final DescriptionController = TextEditingController();
  final hoursController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    DescriptionController.dispose();
    hoursController.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  bool title = false;
  bool descript = false;
  bool hours = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(80),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 108, 248, 253)),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Column(children: [
                    const Text("Write a title for your job!"),
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                            controller: titleController,
                            onChanged: (t) {
                              setState(() {
                                title = t.isNotEmpty;
                                widget.title1 = t.toString();
                              });
                            })),
                    const Text("Write a description"),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            controller: DescriptionController,
                            onChanged: (t) {
                              setState(() {
                                descript = t.isNotEmpty;
                                widget.descript1 = t;
                              });
                            })),
                    const Text("How many hours"),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                            controller: hoursController,
                            onChanged: (t) {
                              setState(() {
                                hours = t.isNotEmpty;
                                widget.hours1 = t;
                              });
                            })),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreenNav()));
                        },
                        child: const Text("Submit job")),
                    RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                                hours
                                    ? Icons.check
                                    : Icons.sentiment_dissatisfied,
                                size: 14,
                                color: hours
                                    ? Colors.green.shade600
                                    : Colors.red.shade300))
                      ]),
                    )
                  ]))
            ])),
      ),
    );
  }
}
