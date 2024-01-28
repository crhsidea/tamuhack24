import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              /*
              Text(
                "Sus Amogus",
                style: TextStyle(fontSize: 24),
              )
              */
              FutureBuilder(
                future: supabase
                    .from("profiles")
                    .select('(id, full_name)')
                    .match({'id': supabase.auth.currentUser!.id}),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("...", style: TextStyle(fontSize: 24));
                  }
                  return Text(snapshot.data![0]['full_name'],
                      style: TextStyle(fontSize: 24));
                },
              ),
            ],
          ),
          Column(
            children: [
              // FutureBuilder(
              //   future: supabase.storage.from('resumes').list(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<FileObject>> snapshot) {
              //     if (!snapshot.hasData) {
              //       return Container();
              //     }

              //     for (FileObject file in snapshot.data!.toList()) {
              //       if (file.name ==
              //           'user-${supabase.auth.currentUser?.id}/resume.pdf') {
              //         return Container();
              //       }

              //       return Text("SUS");
              //     }

              //     return Container();
              //   },
              // ),
              SizedBox(
                height: 42,
                width: 200,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        final String path =
                            await supabase.storage.from('resumes').upload(
                                  'user-${supabase.auth.currentUser?.id}/resume.pdf',
                                  file,
                                  fileOptions: const FileOptions(
                                      cacheControl: '3600', upsert: false),
                                );
                      }
                    },
                    child: Text(
                      "Upload resume!",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(height: 12.5),
              SizedBox(
                height: 42,
                width: 200,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                  onPressed: () async {
                    await supabase.auth.signOut();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Sign out",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 12.5),
              SizedBox(
                height: 42,
                width: 200,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                    child: Text(
                      "Test images",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await getImagesForListing("");
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
