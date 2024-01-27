import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Listing {
	final String id;
	final String title;
	final String content;
	final String user_id;
	final String location;
	final int hours;
	final DateTime created_at;
	final List<String> questions;

	Listing({
		required this.id,
		required this.user_id,
		required this.content,
		required this.created_at,
		required this.location,
		required this.hours,
		required this.title,
		required this.questions,
	});
	
	Listing.fromJSON(Map<String, dynamic> d) :
		id = d["id"],
		user_id = d["user_id"],
		content = d["content"],
		created_at = DateTime.parse(d["created_at"]),
		location = d["location"],
		hours = d["hours"],
		title = d["title"],
		questions = json.decode(d["questions"])
		;

	Map<String, dynamic> toJSON() {
		return {
			"id": id,
			"user_id": user_id,
			"content": content,
			"created_at": created_at,
			"title": title,
			"location": location,
			"hours": hours,
			"questions": json.encode(questions),
		};
	}

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "owner_id": owner_id,
      "content": content,
      "created_at": created_at,
      "title": title,
      "location": location,
      "hours": hours,
    };
  }
}

Future<void> addListing({
	required String title,
	required String content,
	required String location,
	required int hours,
}) async {
	await supabase.from("joblistings").insert({
		"title" : title,
		"content" : content,
		"location" : location,
		"hours" : hours,
	});
}

Future<List<Listing>> getListingsByUser(String? uid) async {
	List<Map<String, dynamic>> data = await supabase
			.from("joblistings")
			.select('(id,user_id,created_on,title,content,location,hours)')
			.eq("user_id", uid ?? supabase.auth.currentUser!.id);
	List<Listing> list_data = data.map((d) => Listing.fromJSON(d)).toList();
	return list_data;
}
