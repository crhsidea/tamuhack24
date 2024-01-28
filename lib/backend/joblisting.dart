import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
  final double salary;

  Listing(
      {required this.id,
      required this.user_id,
      required this.content,
      required this.created_at,
      required this.location,
      required this.hours,
      required this.title,
      required this.questions,
      required this.salary});

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "user_id": user_id,
      "content": content,
      "created_at": created_at,
      "title": title,
      "location": location,
      "hours": hours,
      "salary": salary
    };
  }
}

Listing ListingFromJSON(Map<String, dynamic> d) {
  print("Delisting");
  var id = d["id"].toString();
  var user_id = d["user_id"].toString();
  var content = d["content"].toString();
  var location = d["location"].toString();
  var hours = d["hours"].toInt();
  var title = d["title"].toString();
  double salary;
  if (d["salary"] == null)
    salary = 0;
  else
    salary = d["salary"].toDouble();
  print(salary);
  print(d["created_at"]);
  DateTime dt;
  if (d["created_at"] == null) {
    dt = DateTime.now();
  } else {
    dt = DateTime.parse(d["created_at"].toString());
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
    salary: salary,
  );
  print(a);
  return a;
}

Future<String> addListing({
  required String title,
  required String content,
  required String location,
  required int hours,
  required List<String> questions,
  required double salary,
}) async {
  var data = await supabase.from("joblistings").insert({
    "title": title,
    "content": content,
    "location": location,
    "hours": hours,
    "salary": salary,
  }).select();

  await supabase.from("questions").insert(questions
      .mapIndexed(
          (i, e) => {"listing_id": data[0]["id"], "text": e, "index": i})
      .toList());

	return data[0]["id"];
}

Future<List<Listing>> getListingsByUser(String? uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("joblistings")
      .select('(id,user_id,created_on,title,content,location,hours,salary)')
      .eq("user_id", uid ?? supabase.auth.currentUser!.id);
  List<Listing> list_data = data.map((d) => ListingFromJSON(d)).toList();
  return list_data;
}

Future<Listing> getListingById(String uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("joblistings")
      .select('(id,user_id,created_on,title,content,location,hours,salary)')
      .eq("id", uid);
  List<Listing> list_data = data.map((d) => ListingFromJSON(d)).toList();
  return list_data[0];
}
Future<List<Listing>> getAllListings() async {
  List<Map<String, dynamic>> data = await supabase
      .from("joblistings")
      .select('(id,user_id,created_on,title,content,location,hours,salary)');
  print(data);
  List<Listing> list_data = [];
  for (Map<String, dynamic> d in data) {
    print(d);
    var l = ListingFromJSON(d);
    print(l);

    list_data.add(l);
  }
  return list_data;
}

Future<void> uploadImage(String id, XFile image) async {
	var uuid  = Uuid();
	var data = await image.readAsBytes();
	await supabase.storage.from("jobimages").uploadBinary(
		"/listings/${id}/${uuid.v4()}.jpg",
		data
	);
}

Future<List<Image>> getImagesForListing(String id) async {
	var list = await supabase.storage.from("jobimages").list(path:"listings/$id");
	List<Image> images = [];
	for (FileObject file in list) {
		var data = await supabase.storage.from("jobimages").download("listings/$id/${file.name}");
		images.add(Image.memory(data));
	}
	return images;
}
Future<bool> delete(String uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("joblistings")
      .select('(id,user_id,created_on,title,content,location,hours,salary)')
      .match({'user_id': supabase.auth.currentUser?.id, 'id': uid});
  if (supabase.auth.currentUser?.id == data[0]['user_id']) {
    await supabase
        .from("joblistings")
        .delete()
        .match({'user_id': supabase.auth.currentUser?.id, 'id': uid});
    return true;
  } else {
    return false;
  }
}
