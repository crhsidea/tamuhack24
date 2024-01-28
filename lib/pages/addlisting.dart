import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flacktest/backend/joblisting.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:image_picker/image_picker.dart';

class AddListingPage extends StatefulWidget {
  @override
  State<AddListingPage> createState() => AddListingPageState();
}

class AddListingPageState extends State<AddListingPage> {
  final formKey = GlobalKey<FormState>();
  int numQuestions = 1;

  TextEditingController name = TextEditingController();
  TextEditingController hours = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController salary = TextEditingController();
  List<String> otherAns = [];
  List<XFile> images = [];

  final ImagePicker picker = ImagePicker();

  List<Widget> genList(int count) {
    List<Widget> out = [];
    for (int i = 0; i < count; i++) {
      out.add(TextFormField(
        onChanged: (text) {
          otherAns[i] = text;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Something scintillating you\'d love to learn',
        ),
      ));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Align(
              alignment: Alignment.topLeft,
              child: 
									 Container(
											decoration: BoxDecoration(
											borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
											color: Color(0xFF065A82),
										),
										width: MediaQuery.of(context).size.width,
										height: 400,
										child: Padding(
											padding: EdgeInsets.all(16.0),
											child: Column(
											 crossAxisAlignment: CrossAxisAlignment.start,
											 children:	[
												Text("New Listing", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 64.0)),
												SizedBox(
													width: 100,
													height: 100,
													child: Image.asset("images/ftpen.png")
												)
											]
											)
										),
								),
					),
          SizedBox(height: 50),
          Padding(
              padding: EdgeInsets.all(32.0),
              child: Form(
                  key: formKey,
                  child: Column(
                      children: (<Widget>[
                                    TextFormField(
                                      controller: name,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Position name',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: hours,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Hours per week',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: salary,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Hourly salary',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: location,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Location',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: desc,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Job description'),
                                      minLines: 3,
                                      maxLines: 50,
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText:
                                              'Number of interview questions',
                                        ),
                                        onChanged: (t) {
                                          setState(() {
                                            numQuestions = int.parse(t);
                                            while (otherAns.length <
                                                numQuestions) {
                                              otherAns.add("");
                                            }
                                          });
                                        })
                                  ] +
                                  genList(numQuestions))
                              .map((e) => Padding(
                                  padding: EdgeInsets.only(bottom: 50),
                                  child: e) as Widget)
                              .toList() +
                          <Widget>[
                            ElevatedButton(
                              onPressed: () async {
                                images = await picker.pickMultiImage();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width - 250,
                                    30),
                                backgroundColor: Color(0xFF91A6FF),
                              ),
                              child: Text(
                                "Add some images?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  String id = await addListing(
                                      title: name.text,
                                      content: desc.text,
                                      location: location.text,
                                      hours: int.parse(hours.text),
                                      salary: double.parse(salary.text),
                                      questions: otherAns);
                                  for (XFile image in images) {
                                    await uploadImage(id, image);
                                  }
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 75),
                                  backgroundColor: Color(0xFF065A82),
                                ),
                                child: Text(
                                  "Create your listing",
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )),
                            SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width - 200,
                                      50),
                                  backgroundColor: Color(0xFFBA2D0B),
                                ),
                                child: Text(
                                  "Return to view",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )),
                          ]))),
          Container(
            height: 48,
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.indigo[400]!,
                  Colors.indigo[300]!,
                  Colors.indigo[200]!,
                  Colors.indigo[100]!
                ],
                durations: [18000, 8000, 5000, 12000],
                heightPercentages: [0.65, 0.66, 0.68, 0.84],
              ),
              size: Size(double.infinity, double.infinity),
              waveAmplitude: 1,
            ),
          ),
        ]))));
  }
}
