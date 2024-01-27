
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

class Message {
	final String id;
	final String user_id;
	final String rec_id;
	final String content;
	final DateTime created_at;
	final bool mine;

	Message({
		required this.id,
		required this.user_id,
		required this.content,
		required this.created_at,
		required this.mine,
	});
	
	Message.fromJSON(Map<String, dynamic> d, String myId) :
		id = d["id"],
		user_id = d["user_id"],
		content = d["content"],
		created_at = DateTime.parse(d["created_at"]),
		mine = d["sender_id"] == myId;

	Map<String, dynamic> toJSON() {
		return {
			"id": id,
			"user_id": user_id,
			"content": content,
			"created_at": created_at,
		};
	}
}

Future<void> send({required String to, required String contents}) async {
	await supabase.from("joblistings").insert({
		"user_id":	to,
		"content": contents,
	});
}

Future<List<Joblisting>> getAllJoblistings() async {
	print("Supabasing messages");
	var data = await supabase.from("joblistings").select<List<Map<String, dynamic>>>();
	print("JobListings are: $data");
	List<Message> msgs = [];
	for (Map<String, dynamic> json in data)
		msgs.add(Message.fromJSON(json, supabase.auth.currentUser!.id));
	return msgs;
}

Future<List<Message>> getMessagesTo(String user_id, String my_id) async {
	List<Joblisting> data = await getAllJoblistings();
	List<Joblisting> msgs = [];
	for (Joblisting m in data)
		if (m._id == my_id || m.sender_id == user_id)
		msgs.add(m);
	return msgs;
}class Joblisting{
  final
}
