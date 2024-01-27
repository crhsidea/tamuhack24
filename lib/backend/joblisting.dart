import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

class Listing {
	final String id;
	final String title;
	final String content;
	final String owner_id;
	final String location;
	final int hours;
	final DateTime created_at;

	Listing({
		required this.id,
		required this.owner_id,
		required this.content,
		required this.created_at,
		required this.location,
		required this.hours,
		required this.title
	});
	
	Listing.fromJSON(Map<String, dynamic> d) :
		id = d["id"],
		owner_id = d["owner_id"],
		content = d["content"],
		created_at = DateTime.parse(d["created_at"]),
		location = d["location"],
		hours = d["hours"],
		title = d["title"]
		;

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

	Future<void> add() async {
		await supabase.from("joblistings").insert(toJSON());
	}
}

Future<List<Listing>> getListingByUser(String uid) async {
	List<Map<String, dynamic>> data = await supabase.from("joblistings").select('*').eq("owner_id", uid);
	print(data);
	return [];
}
