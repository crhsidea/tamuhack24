import 'package:flutter/material.dart';

class ApplicationStatus extends StatelessWidget {
  final bool status;
  final String jobName;
  const ApplicationStatus(
      {super.key, required this.status, required this.jobName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text("Accepted ${status.toString()}"),
          Text("Job Name: $jobName")
        ],
      ),
    );
  }
}
