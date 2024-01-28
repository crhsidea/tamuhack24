import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flacktest/widget/Initals.dart';

import 'package:flacktest/backend/joblisting.dart';

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
        child: FutureBuilder(
            future: supabase.from("profiles").select("(full_name)"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData)
                return SizedBox(
                    height: 300,
                    width: 300,
                    child: CircularProgressIndicator());
              String initals = snapshot.data![0]["full_name"]
                  ?.split(" ")
                  .map((e) => e[0])
                  .join();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Color(0xFF065A82),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text("Profile",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 64.0)),
                                    Spacer(),
                                    InitialsAvatar(
                                        initials: initals,
                                        backgroundColor: Color(0xFF91A6FF)),
                                  ]),
                                ])),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.lightBlue)),
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                File file = File(result.files.single.path!);
                                final String path = await supabase.storage
                                    .from('resumes')
                                    .upload(
                                      'user-${supabase.auth.currentUser?.id}/resume.pdf',
                                      file,
                                      fileOptions: const FileOptions(
                                          cacheControl: '3600', upsert: false),
                                    );
                              }
                            },
                            child: Text(
                              "Upload your resume",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            )),
                      ),
                      SizedBox(height: 12.5),
                      SizedBox(
                        height: 60,
                        width: 300,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.lightBlue)),
                          onPressed: () async {
                            await supabase.auth.signOut();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Sign out",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.5),
                    ],
                  )
                ],
              );
            }));
  }
}
