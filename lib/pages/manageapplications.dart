import 'package:flutter/material.dart';
import 'package:flacktest/backend/application.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flacktest/widget/Application.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
class ManageApplicationsPage extends StatefulWidget {

	final Listing listing;
	const ManageApplicationsPage({ required this.listing });
  @override
  State<ManageApplicationsPage> createState() => ManageApplicationsPageState();
}

class ManageApplicationsPageState extends State<ManageApplicationsPage> {

  @override
  Widget build (BuildContext context) {
    return Scaffold(
			body: Center(
				child: Column(
					children: [
						Text.rich(
							TextSpan(
								text: "Applications for:\n",
								style: TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 32.0
								),
								children: [
									TextSpan(text: widget.listing.title, style: TextStyle(fontSize: 32.0))
								]
							)
						),
						SizedBox(
							height: 50
						),
						FutureBuilder(
							future: getApplicationsByListing(widget.listing.id),
							builder: (BuildContext context, AsyncSnapshot<List<Application>> snapshot) {
								if (!snapshot.hasData)
									return SizedBox(
										width: 100,
										height: 100,
										child: CircularProgressIndicator());
								return ListView(
									shrinkWrap: true,
									children: snapshot.data!.map((e) => ApplicationView(application: e)).toList()
								);
							}
						)
					]
				)
			)	
		);
  }
}
