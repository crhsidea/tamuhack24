import 'package:flacktest/backend/application.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flacktest/pages/applyform.dart';
import 'package:flacktest/widget/ApplicationCard.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllApplicationsByUser(supabase.auth.currentUser!.id),
      builder:
          (BuildContext context, AsyncSnapshot<List<Application>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        print(snapshot.data);

        return snapshot.data!.length > 0
            ? ListView(
                children: snapshot.data!
                    .map(
                      (e) => Container(
                        color: e.accepted ? Colors.green : Colors.red,
                        child: ApplicationStatus(
                          status: e.accepted,
                          jobName: e.listing_id.toString(),
                        ),
                      ),
                    )
                    .toList(),
              )
            : Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                      "Apply for a job, then come back to check your application status"),
                ),
              );
      },
    );
  }
}
