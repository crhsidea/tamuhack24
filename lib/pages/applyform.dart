import 'package:dynamic_form/dynamic_form.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:flutter/material.dart';

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
                .map((q) => TextElement(id: q["index"], label: q["text"]))
                .toList();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleDynamicForm(
                  controller: controller,
                  groupElements: [
                    GroupElement(
                      directionGroup: DirectionGroup.Vertical,
                      textElements: formTextItems,
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () => print(controller.getAllValues()),
                    child: Text("Print values to debug console"))
              ],
            );
          }),
    );
  }
}
