import 'package:flutter/material.dart';
import 'package:flacktest/backend/application.dart';

class ApplicationStatus extends StatelessWidget {
	final Application application;
  const ApplicationStatus(
      {super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text("Accepted ${application.accepted.toString()}"),
        ],
      ),
    );
  }
}
