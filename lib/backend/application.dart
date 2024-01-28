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
  List<String> questions;
  final String user_name;
  final DateTime created_at;
  final bool accepted;

  Application({
    required this.id,
    required this.user_id,
    required this.user_name,
    required this.listing_id,
    required this.answers,
    required this.created_at,
    required this.accepted,
    required this.questions,
  });

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

Application ApplicationFromJSON(Map<String, dynamic> d) {
  return Application(
      id: d["id"].toString(),
      user_id: d["user_id"].toString(),
      listing_id: d["listing_id"].toString(),
      created_at: DateTime.parse(d["created_at"].toString()),
      accepted: d["accepted"],
      user_name: "",
      questions: [],
      answers: []);
}

Future<void> acceptApplication(String id, bool accepted) async {
  await supabase
      .from("applications")
      .update({"accepted": accepted}).eq("id", id);
}

Future<void> addApplication({
  required String listing_id,
  required List<String> answers,
}) async {
  var data = await supabase.from("applications").insert({
    "listing_id": listing_id,
  }).select();
  print(data);

  var questions = await supabase
      .from("questions")
      .select("(id, index)")
      .eq("listing_id", listing_id);
  questions.sort((a, b) => a["index"].toInt().compareTo(b["index"].toInt()));
  List<Map<String, dynamic>> answer_data = answers
      .mapIndexed((i, e) =>
          {"text": e, "index": i, "question_id": questions[i]["id"].toString()})
      .toList();
  for (Map<String, dynamic> d in answer_data) {
    print(d);
    await supabase.from("answers").insert(d);
  }

  await supabase
      .from("answers")
      .insert(answers.mapIndexed((i, e) => {"text": e, "index": i}).toList());
}

Future<List<Application>> getApplicationsByListing(String uid) async {
  print("Starting fetch applications");
  List<Map<String, dynamic>> data = await supabase
      .from("applications")
      .select('(id,user_id,listing_id,created_on,accepted)')
      .eq("listing_id", uid);

  List<Application> list_data = [];
  for (Map<String, dynamic> json in data) {
    Application a = ApplicationFromJSON(json);

    List<Map<String, dynamic>> questions = await supabase
        .from("questions")
        .select("(index, text)")
        .eq("listing_id", uid);
    questions.sort((a, b) => a["index"].toInt().compareTo(b["index"].toInt()));
    List<String> questions_s =
        questions.map((e) => e["text"].toString()).toList();

    List<String> answers = [];
    String user_id = "";
    for (var question in questions) {
      var answer1 = await supabase
          .from("answers")
          .select("(user_id, text)")
          .eq("question_id", question["id"]);
      var answer = answer1[0];
      user_id = answer["user_id"];
      answers.add(answer["text"]);
    }
    print(answers);
    a.questions = questions_s;
    a.answers = answers;
    list_data.add(a);
  }
  return list_data;
}

Future<List<Application>> getAllApplicationsByUser(String uid) async {
  List<Map<String, dynamic>> data = await supabase
      .from("applications")
      .select('(id,user_id,listing_id,created_on,answers,accepted)')
      .eq("user_id", uid);
  List<Application> list_data =
      data.map((d) => ApplicationFromJSON(d)).toList();
  return list_data;
}
