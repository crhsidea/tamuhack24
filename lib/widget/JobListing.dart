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
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: widget.listing.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: '\n',
                            style: DefaultTextStyle.of(context).style),
                        TextSpan(
                            text: widget.listing.location + "\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 26.0)),
                        TextSpan(
                            text: "\$${widget.listing.salary}/hr",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 24.0)),
                      ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: GestureDetector(
                      child: Icon(Icons.delete_forever, color: Colors.red),
                      onTap: () async {
                        var sus = await delete(widget.listing.id);
                        print(sus);
                        setState(() {});
                      },
                    ),
                  ),
                )
              ],
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
                          child: Image.network("https://picsum.photos/200"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.network("https://picsum.photos/200"),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
        Text(widget.listing.content,
            style: TextStyle(color: Colors.black, fontSize: 22.0)),
      ],
    ));
  }
}
