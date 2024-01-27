//job location
//description
//
import 'package:flutter/material.dart';
import 'package:flacktest/backend/joblisting.dart';

class ListingCard extends StatefulWidget{
  final String id;
  const ListingCard({super.key, required this.id, required this.listing});
  final Listing listing;
  @override
  State<ListingCard> createState()=> ListingCardState();
}

class ListingCardState extends State<ListingCard>{
  @override
  Widget build(BuildContext context) {
      return Card(
        clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(children: [Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.amber,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 12.0,
                            ),
                            child: Text(
                              '\$${widget.listing.title}',
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