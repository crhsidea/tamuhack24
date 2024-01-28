import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collection/collection.dart';

final supabase = Supabase.instance.client;

class Application {
  final String id;
  final String listing_id;
  final String user_id;
  List<String> answers;
  final DateTime created_at;

  Application({
    required this.id,
    required this.user_id,
    required this.listing_id,
    required this.answers,
    required this.created_at,
  });

  Application.fromJSON(Map<String, dynamic> d)
      : id = d["id"],
        user_id = d["user_id"],
        listing_id = d["listing_id"],
        created_at = DateTime.parse(d["created_at"]),
				answers = [];

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "user_id": user_id,
      "listing_id": listing_id,
      "created_at": created_at,
    };
  }
}

Future<void> addApplication({
  required String listing_id,
  required List<String> answers,
}) async {
  var data = await supabase.from("applications").insert({
    "listing_id": listing_id,
  })
	.select();
	print(data);

	var questions = await supabase.from("questions")
			.select("(id, index)")
			.eq("listing_id", listing_id);
	questions.sort((a, b) => a["index"].toInt().compareTo(b["index"].toInt()));
	await supabase.from("answers")
			.insert(answers.mapIndexed((i, e) => {"text" : e, "index": i, "question_id": questions[i]["id"]}).toList());
				
}

Future<List<Application>> getApplicationsByListing(String uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("applications")
      .select('(id,user_id,listing_id,created_on,answers)')
      .eq("listing_id", uid);
  List<Application> list_data =
      data.map((d) => Application.fromJSON(d)).toList();
  return list_data;
}
