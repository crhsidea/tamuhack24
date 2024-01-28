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
  final bool accepted;

  Application({
    required this.id,
    required this.user_id,
    required this.listing_id,
    required this.answers,
    required this.created_at,
    required this.accepted,
  });

  Application.fromJSON(Map<String, dynamic> d)
      : id = d["id"],
        user_id = d["user_id"],
        listing_id = d["listing_id"],
        created_at = DateTime.parse(d["created_at"]),
        accepted = d["accepted"],
        answers = [];

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "user_id": user_id,
      "listing_id": listing_id,
      "created_at": created_at,
      "accepted": accepted
    };
  }
}

Future<void> addApplication({
  required String listing_id,
  required List<String> answers,
}) async {
  var data = await supabase.from("applications").insert({
    "listing_id": listing_id,
  }).select();
  print(data);

  await supabase
      .from("answers")
      .insert(answers.mapIndexed((i, e) => {"text": e, "index": i}).toList());
}

Future<List<Application>> getApplicationsByListing(String uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("applications")
      .select('(id,user_id,listing_id,created_on,answers,accepted)')
      .eq("listing_id", uid);
  List<Application> list_data =
      data.map((d) => Application.fromJSON(d)).toList();
  return list_data;
}

Future<List<Application>> getAllApplicationsByUser(String uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("applications")
      .select('(id,user_id,listing_id,created_on,answers,accepted)')
      .eq("user_id", uid);
  List<Application> list_data =
      data.map((d) => Application.fromJSON(d)).toList();
  return list_data;
}
