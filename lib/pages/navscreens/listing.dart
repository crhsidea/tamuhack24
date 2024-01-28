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
            child: Stack(children: [
              Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 16.0),
											child: Align(
												alignment: Alignment.centerLeft,
												child: Text("Listings", style: TextStyle(color: Color(0xFF065A82), fontWeight: FontWeight.bold, fontSize: 64.0)),
											),
									)
                ),
								Padding(
									padding: EdgeInsets.all(24.0),
									child: ElevatedButton(
										onPressed: () {
											Navigator.of(context).push(MaterialPageRoute(
													builder: (context) => AddListingPage()));
										},
										style: ElevatedButton.styleFrom(
											minimumSize: Size(
													MediaQuery.of(context).size.width - (24+16)*2,
													75),
											backgroundColor: Color(0xFF91A6FF),
										),
										child: Text(
											"Add a listing!",
											style: TextStyle(
												fontWeight: FontWeight.w600,
												fontSize: 44.0,
												color: Colors.white,
											)
										)
									),
								),
                FutureBuilder(
                    future: getListingsByUser(supabase.auth.currentUser!.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Listing>> snapshot) {
                      if (!snapshot.hasData)
                        return SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator());
                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!
                              .map((e) => JobListing(listing: e))
                              .toList(),
                        ),
                      );
                    })
              ]),
            ])));
  }
}
