import 'package:dynamic_form/dynamic_form.dart';
import 'package:flacktest/backend/application.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ApplyForm extends StatefulWidget {
  const ApplyForm({super.key, required this.listing});
  final Listing listing;

  @override
  State<ApplyForm> createState() => _ApplyFormState();
}

class _ApplyFormState extends State<ApplyForm> {
  FormController controller = FormController();
  // List<TextElement> formTextItems = [TextElement(id: "test", label: "test")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: supabase
              .from("questions")
              .select("(index,text)")
              .match({'listing_id': widget.listing.id}),
          builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<TextElement> formTextItems = snapshot.data!
                .map(
                  (q) => TextElement(
                    id: q["index"].toString(),
                    label: q["text"],
                  ),
                )
                .toList();
            return SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Color(0xFF065A82),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 435,
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Applying",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 64.0)),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.asset("images/celeb.png"),
                            ),
                            Text(
                                "It's time to apply!\nRemember, answer honestly and always put your best foot forward.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24.0))
                          ])),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SimpleDynamicForm(
                    controller: controller,
                    groupElements: [
                      GroupElement(
                        directionGroup: DirectionGroup.Vertical,
                        textElements: formTextItems,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        print(controller.getAllValues());
                        try {
                          await addApplication(
                              listing_id: widget.listing.id,
                              answers: controller.getAllValues());
                        } on PostgrestException catch (e) {
                          print("oops... ${e.message}");
                          print("anyways...");
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 75),
                        backgroundColor: Color(0xFF065A82),
                      ),
                      child: Text(
                        "Apply!",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width - 200, 50),
                      backgroundColor: Color(0xFFBA2D0B),
                    ),
                    child: Text(
                      "I've changed my mind",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              ],
            ));
          }),
    );
  }
}
