import 'package:flutter/material.dart';
import 'package:flacktest/backend/application.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationView extends StatefulWidget {
  final Application application;
  const ApplicationView({required this.application});

  @override
  State<ApplicationView> createState() => ApplicationViewState();
}

class ApplicationViewState extends State<ApplicationView> {
	String status = "";
	Color statusColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Name: ${widget.application.user_name}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
						subtitle: Text(
							"Status: $status",
							style: TextStyle(
								color: statusColor
							)
						)
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.application.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index > widget.application.questions.length) return null;
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Column(children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.application.questions[index],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(widget.application.answers[index])),
                            SizedBox(height: 8.0),
                          ]),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          GestureDetector(
            child: Container(
              child: Center(
                child: Text(
                  "View resume",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              height: 30,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
            ),
            onTap: () {
              launchUrl(Uri.parse(widget.application.resume_link));
            },
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await acceptApplication(widget.application.id, false);
                    setState(() {
											status = "rejected";
											statusColor = Colors.red;
										});
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(175, 90),
                      backgroundColor: Color(0xFFBA2D0B)),
                  child: Text("Reject",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
              ElevatedButton(
                  onPressed: () async {
                    await acceptApplication(widget.application.id, true);
                    setState(() {
											status= "accepted";
											statusColor = Colors.green;
										});
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(175, 90),
                      backgroundColor: Colors.lightGreen),
                  child: Text("Accept",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
            ],
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
