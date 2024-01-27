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
	final List<dynamic> questions;

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
}


Listing ListingFromJSON(Map<String, dynamic> d) {
	print("Delisting");
	print(d["questions"]);
	var id = d["id"];
	var user_id = d["user_id"];
	var content = d["content"];
	var location = d["location"];
	var hours = d["hours"];
	var title = d["title"];
	var questions = d["questions"];
	print(questions);
	var dt = DateTime.parse("2024-01-27T21:02:29");
	print("eccessed");
	
	var a =  Listing(
		id : id,
		user_id : user_id,
		content : content,
		created_at : dt,
		location : location,
		hours : hours,
		title : title,
		questions : [],
	);
	print(a);
	return a;
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
	List<Listing> list_data = data.map((d) => ListingFromJSON(d)).toList();
	return list_data;
}
Future<List<Listing>> getAllListings() async {
	List<Map<String, dynamic>> data = await supabase
			.from("joblistings")
			.select('(id,user_id,created_on,title,content,location,hours)');
	print(data);
	List<Listing> list_data = [];
	for (Map<String, dynamic> d in data) {
		print(d);
		var l = ListingFromJSON(d);
		print(l);
		list_data.add(l);
	}
	print("DONE WITH LOOP");
	print(list_data);
	return list_data;
}
