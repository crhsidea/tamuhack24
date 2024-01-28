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
  List<dynamic> questions;
  List<dynamic> images;

  Listing({
    required this.id,
    required this.user_id,
    required this.content,
    required this.created_at,
    required this.location,
    required this.hours,
    required this.title,
    required this.questions,
    required this.images,
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
      "images": json.encode(images),
    };
  }
}

Listing ListingFromJSON(Map<String, dynamic> d) {
  print("Delisting");
  var id = d["id"]!;
  var user_id = d["user_id"]!;
  var content = d["content"]!;
  var location = d["location"]!;
  var hours = d["hours"]!;
  var title = d["title"]!;
  print(d["created_at"]);
  DateTime dt;
  if (d["created_at"] == null) {
    dt = DateTime.now();
  } else {
    dt = DateTime.parse(d["created_at"]!);
  }
  print("eccessed");

  var a = Listing(
    id: id,
    user_id: user_id,
    content: content,
    created_at: dt,
    location: location,
    hours: hours,
    title: title,
    questions: [],
    images: [],
  );
  print(a);
  return a;
}

Future<void> addListing({
  required String title,
  required String content,
  required String location,
  required int hours,
	required List<String> questions,
}) async {
  var data = await supabase.from("joblistings").insert({
    "title": title,
    "content": content,
    "location": location,
    "hours": hours,
  }).select();

	await supabase.from("questions")
			.insert(questions.map((e) => { "listing_id": data[0]["id"], "text": e }).toList());
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
    var images =
        await supabase.from("images").select("id").eq("listing_id", l.id);
    List<String> images_s = images.map((x) => x["id"].toString()).toList();
    l.images = images_s;

    list_data.add(l);

    var questions = await supabase
        .from("questions")
        .select("(index, text)")
        .eq("listing_id", l.id);
    questions.sort((a, b) => a["index"].toInt().compareTo(b["index"].toInt()));
    l.questions = questions.map((x) => x["text"].toString()).toList();
  }
  return list_data;
}
