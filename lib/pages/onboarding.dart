import 'package:flacktest/backend/application.dart';
import 'package:flacktest/widgets/onboarding_menu_tray.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width - 17,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn.dribbble.com%2Fusers%2F177698%2Fscreenshots%2F1074614%2Fattachments%2F133093%2FRocket-Ship-to-Moon.png&f=1&nofb=1&ipt=61d45263e2e52c90e2f305ba7994a72631878600dfe1a1dae45efb336f73218d&ipo=images"),
              ),
              SizedBox(height: 15),
              Text(
                "Get a job, as a high schooler",
                style: TextStyle(fontSize: 27.5),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 52,
                child: TextButton(
                    child: const Text("Lets do it",
                        style: const TextStyle(color: Colors.white)),
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
            ],
          ),
        ),
      ),
    );
  }
}
