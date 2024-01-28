import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flacktest/widget/JobListing.dart';
import 'package:flacktest/pages/addlisting.dart';

final supabase = Supabase.instance.client;

class ListingsPage extends StatefulWidget {
	const ListingsPage({super.key});

	@override
	State<ListingsPage> createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
	@override
	Widget build(BuildContext context) {
		return Center(
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Stack(
					children: [
						Align(
							alignment: Alignment.bottomRight,
							child: SizedBox(
								width: 60,
								height: 60,
								child: Ink(
									decoration: const ShapeDecoration(
										color: Colors.lightBlue,
										shape: CircleBorder(),
									),
									child: IconButton(
										icon: const Icon(Icons.add, size: 30),
										color: Colors.white,
										onPressed: () {
											Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddListingPage()));
										}
									),
								),
							),
						),
						Column(
							children: [
								Align(
									alignment: Alignment.centerLeft,
									child: Padding(
										padding: EdgeInsets.only(left: 16.0, top: 16.0),
										child: Text(
											"Your listings",
											style: TextStyle(
												fontSize: 56.0,
												fontWeight: FontWeight.bold,
											)
										)
								),
								),
								FutureBuilder(
									future: getListingsByUser(supabase.auth.currentUser!.id),
									builder: (BuildContext context, AsyncSnapshot<List<Listing>> snapshot) {
										if (!snapshot.hasData)
											return SizedBox(
												height: 100,
												width: 100,
												child: CircularProgressIndicator()
											);
										return ListView(
											shrinkWrap: true,
											children: snapshot.data!.map((e) => JobListing(listing: e)).toList(),
										);
									}
								)
							]
						)
					]
				)	
			)
		);
	}
}
