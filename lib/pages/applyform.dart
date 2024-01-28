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
                  onPressed: () async {
                    print(controller.getAllValues());
                    await addApplication(
                        listing_id: widget.listing.id,
                        answers: controller.getAllValues());
                    Navigator.pop(context);
                  },
                  child: const Text("Submit form"),
                )
              ],
            );
          }),
    );
  }
}
