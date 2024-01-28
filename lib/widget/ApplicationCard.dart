import 'package:flutter/material.dart';
import 'package:flacktest/backend/application.dart';
import 'package:flacktest/backend/joblisting.dart';

class ApplicationStatus extends StatelessWidget {
	final Application application;
	final Listing listing;

  const ApplicationStatus(
      {super.key, required this.application, required this.listing});

	Icon getIcon() {
		if (application.accepted == null)
			return Icon(Icons.access_time, color: Colors.blue);
		else if (!application.accepted!)
			return Icon(Icons.cancel, color: Colors.red);
		else
			return Icon(Icons.check, color: Colors.green);

	}
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
					ListTile(
						leading: getIcon(),
						title: Text(listing.title),
						subtitle: Text(application.created_at.toString()),
					)
        ],
      ),
    );
  }
}
