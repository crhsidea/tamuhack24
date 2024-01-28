import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.lightBlue,
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://static.wikia.nocookie.net/amogus/images/c/cb/Susremaster.png/revision/latest/scale-to-width-down/700?cb=20210806124552"),
              ),
              Text(
                "Sus Amogus",
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your name',
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await supabase.auth.signOut();
                    Navigator.of(context).pop();
                  },
                  child: Text("Sign out"))
            ],
          )
        ],
      ),
    );
  }
}
