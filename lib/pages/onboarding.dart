import 'package:flacktest/backend/application.dart';
import 'package:flacktest/widgets/onboarding_menu_tray.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.center,
            children: [
								Padding(
									padding: EdgeInsets.only(top: 32.0, left: 32.0, bottom: 16.0),
									child: Align(
										alignment: Alignment.centerLeft,
										child: Text("JobJet", style: TextStyle(color: Color(0xFF065A82), fontWeight: FontWeight.bold, fontSize: 64.0)),
									),
								),
              Container(
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width - 17,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset("images/rocket.png"),
							),
							Padding(
								padding: EdgeInsets.all(32.0),
								child: Text(
										"Get a job, as a high schooler",
										style: TextStyle(fontSize: 18.0,
										color: Color(0xFF065A82))
									),
							),
							Padding(
								padding: EdgeInsets.only(left: 32.0),
								child: Text(
									"It's as easy as one..., two... BRRRING!",
									style: TextStyle(
										fontSize: 18.0,
										color: Color(0xFF065A82)
									),
								),
							),
							Spacer(),
							Padding(
								padding: EdgeInsets.all(48.0),
								child: SizedBox(
									width: MediaQuery.of(context).size.width ,
									height: 100,
									child: TextButton(
											child: const Text("Let's do it!",
													style: const TextStyle(color: Colors.white,fontSize: 36.0)),
											style: ButtonStyle(
													backgroundColor:
															MaterialStatePropertyAll<Color>(Colors.lightBlue)),
											onPressed: () {
												showMaterialModalBottomSheet(
													context: context,
													clipBehavior: Clip.hardEdge,
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.only(
																topLeft: Radius.circular(15),
																topRight: Radius.circular(15)),
													),
													builder: (context) => OnboardingMenuTray(),
												);
											}),
								),
							),
          Container(
            height: 48,
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Color(0xFF91A6FF),
                  Color(0xFFBA2D0B),
                  Color(0xFF065A82),
                  Color(0xFF065A82),
                ],
                durations: [18000, 8000, 5000, 12000],
                heightPercentages: [0.24, 0.37, 0.64, 0.85],
              ),
              size: Size(double.infinity, double.infinity),
              waveAmplitude: 1,
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
