import 'package:flutter/material.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class JobListing extends StatefulWidget {
  const JobListing({
    super.key,
    required this.listing,
  });
  final Listing listing;
  @override
  State<JobListing> createState() => JobListingState();
}

class JobListingState extends State<JobListing> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            color: Color(0xFF0AFFED),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(24.0),
                    child: RichText(
                      text: TextSpan(
                          text: widget.listing.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 32.0,
                            color: Color(0xFF065A82),
                          ),
                          children: [
                            TextSpan(
                                text: '\n',
                                style: DefaultTextStyle.of(context).style),
                            TextSpan(
                                text: widget.listing.location + "\n",
                                style: TextStyle(
                                    color: Color(0xFF065A82),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 26.0)),
                            TextSpan(
                                text: "\$${widget.listing.salary}/hr",
                                style: TextStyle(
                                    color: Color(0xFF065A82),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 24.0)),
                          ]),
                    )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
									child: Row(
										children: [
											SizedBox(
												width: MediaQuery.of(context).size.width - 64,
												height: 250,
												child: FutureBuilder(
													future: getImagesForListing(widget.listing.id),
													builder: (BuildContext context, AsyncSnapshot<List<Image>> snapshot) {
														if (!snapshot.hasData)
															return SizedBox(
																height: 100,
																width: 100,
																child: CircularProgressIndicator()
															);
														return ListView(
															shrinkWrap: true,
															scrollDirection: Axis.horizontal,
															children: snapshot.data!.map((e) => Padding(
																	padding: EdgeInsets.all(16.0),
																	child: SizedBox(
																		width: 200,
																		height: 200,
																		child: e
																	)
																	)
															).toList()
														);
													}
												),
													)
											],
										),
									),
                Text(widget.listing.content,
                    style: TextStyle(color: Color(0xFF065A82), fontSize: 22.0)),
              ],
            )));
  }
}
