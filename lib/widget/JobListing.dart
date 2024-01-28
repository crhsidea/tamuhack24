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
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          "https://picsum.photos/200"),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                        "https://picsum.photos/200"),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Text(widget.listing.content,
                    style: TextStyle(color: Color(0xFF065A82), fontSize: 22.0)),
              ],
            )));
  }
}
