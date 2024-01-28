import 'package:flutter/material.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flacktest/widget/JobListing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 32.0, left: 32.0, bottom: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Home", style: TextStyle(color: Color(0xFF065A82), fontWeight: FontWeight.bold, fontSize: 64.0)),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(32.0),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                /*onTap: () {
											controller.openView();
										},*/
                onChanged: (_) {
                  print(controller.text);
                },
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                      })
                ]);
          },
          suggestionsBuilder: (_, _b) {
            return [];
          },
        ),
      ),
      FutureBuilder(
          future: getAllListings(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Listing>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                  width: 100, height: 100, child: CircularProgressIndicator());
            }
            print(snapshot.data);
            return Expanded(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map((x) => JobListing(listing: x))
                      .toList(),
                ),
              ),
            );
          })
    ]));
  }
}
