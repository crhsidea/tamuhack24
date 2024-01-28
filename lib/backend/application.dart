import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Application {
  final String id;
  final String listing_id;
  final String user_id;
  final List<String> answers;
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
        answers = List<String>.from(json.decode(d["answers"]));

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "user_id": user_id,
      "listing_id": listing_id,
      "created_at": created_at,
      "answers": json.encode(answers),
    };
  }
}

Future<void> addApplication({
  required String listing_id,
  required List<String> answers,
}) async {
  await supabase.from("applications").insert({
    "listing_id": listing_id,
    "answers": json.encode(answers),
  });
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
