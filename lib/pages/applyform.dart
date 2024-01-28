import 'package:dynamic_form/dynamic_form.dart';
import 'package:flutter/material.dart';

class ApplyForm extends StatefulWidget {
  const ApplyForm({super.key});

  @override
  State<ApplyForm> createState() => _ApplyFormState();
}

class _ApplyFormState extends State<ApplyForm> {
  FormController controller = FormController();
  List<TextElement> formTextItems = [TextElement(id: "test", label: "test")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
      ),
    );
  }
}
