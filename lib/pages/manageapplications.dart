import 'package:flutter/material.dart';
import 'package:flacktest/backend/application.dart';
import 'package:flacktest/backend/joblisting.dart';

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
								text: "Applications for",
								style: TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 64.0
								),
								children: [
									TextSpan(text: widget.listing.title, style: TextStyle(fontSize: 32.0))
								]
							)
						)
					]
				)
			)	
		);
  }
}
