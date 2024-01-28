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
  Future<List<(Application, Listing)>> getData() async {
    print("GetData");
    print("apps:");
    var apps = await getAllApplicationsByUser(supabase.auth.currentUser!.id);
    List<(Application, Listing)> out_list = [];
    for (Application app in apps) {
      Listing l = await getListingById(app.listing_id);
      out_list.add((app, l));
    }
    print(out_list);
    return out_list;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 32.0, left: 32.0, bottom: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Applications",
              style: TextStyle(
                  color: Color(0xFF065A82),
                  fontWeight: FontWeight.bold,
                  fontSize: 64.0)),
        ),
      ),
      TextButton(onPressed: () => setState(() {}), child: Text("Refresh")),
      Expanded(
          child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<(Application, Listing)>> snapshot) {
          if (!snapshot.hasData) {
            return 
								SizedBox(
									height:200,
									width:200,
									child:
									CircularProgressIndicator()
								);
          }

          print(snapshot.data);

          return snapshot.data!.length > 0
              ? ListView(
                  children: snapshot.data!
                      .map((e) => Container(
                            child: ApplicationStatus(
                              application: e.$1,
                              listing: e.$2,
                            ),
                          ))
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
      ))
    ]));
  }
}
