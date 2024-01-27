//job location
//description
//
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flacktest/backend/joblisting.dart';
final supabase = Supabase.instance.client;

class JobListing extends StatefulWidget{
  const JobListing({super.key, required this.listing});
  final Listing listing;
  @override
  State<JobListing> createState()=> JobListingState();
}

class JobListingState extends State<JobListing>{
  @override
  Widget build(BuildContext context) {
      return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
							Padding(
								padding: EdgeInsets.all(24.0),
								child: Text(
									widget.listing.title,
									style: TextStyle(
										fontWeight: FontWeight.w500,
										fontSize: 32.0
									)
								)
							),
							Row(
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
								]
							),
              Container(
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
										children: [Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.amber,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 12.0,
                            ),
                            child: Text(
                              widget.listing.title,
                              style: const TextStyle(
                                color: Colors.blueGrey, 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text('\$${widget.listing.content}', overflow:TextOverflow.fade)],
                ),
                ),
                Text('\$${widget.listing.hours}'),
          ],)
      );
   
  }
  
}
