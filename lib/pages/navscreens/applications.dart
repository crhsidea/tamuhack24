import 'package:flacktest/backend/application.dart';
import 'package:flacktest/pages/applyform.dart';
import 'package:flutter/material.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ApplyForm())),
        child: Text("Application test button"));
  }
}
