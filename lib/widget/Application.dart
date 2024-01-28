import 'package:flutter/material.dart';
import 'package:flacktest/backend/application.dart';

class ApplicationView extends StatefulWidget {
	final Application application;
	const ApplicationView({ required this.application });

  @override
  State<ApplicationView> createState() => ApplicationViewState();
}

class ApplicationViewState extends State<ApplicationView> {

  @override
  Widget build (BuildContext context) {
	print(widget.application.user_name);
    return Card(
				child: Column(
					children: [
						ListTile(
							title: Text(widget.application.user_name),
						),
						SizedBox(
							width: MediaQuery.of(context).size.width,
							height: MediaQuery.of(context).size.height / 3,
							child:
						ListView.builder(
							shrinkWrap: true,
							itemCount: widget.application.questions.length,
							itemBuilder: (BuildContext context, int index) {
								if (index > widget.application.questions.length) return null;
								return Column(
									children: [
										Align(
											alignment: Alignment.centerLeft,
											child: Text(widget.application.questions[index])
										),
										SizedBox(height: 8.0),
										Align(
											alignment: Alignment.centerRight,
											child: Text(widget.application.answers[index])
										)
									]
								);
							}
						),
						),
						Row(
							children: [
								ElevatedButton(
									onPressed: () async {

									},
									style: ElevatedButton.styleFrom(
										minimumSize: Size(200,100),
										backgroundColor: Color(0xFFBA2D0B)
									),
									child: Text(
										"Accept",
										style: TextStyle(
											color: Colors.white
										)
									)
								)	
							]
						),
					]
				)
		);
  }
}
