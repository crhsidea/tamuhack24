import 'package:flacktest/backend/application.dart';
// import 'package:flacktest/pages/jobform.dart';
import 'package:flacktest/pages/signin.dart';
import 'package:flacktest/pages/signup.dart';
import 'package:flutter/material.dart';
// import 'package:flacktest/pages/jobform.dart';

class OnboardingMenuTray extends StatelessWidget {
  const OnboardingMenuTray({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 200,
            //   height: 42,
            //   child: TextButton(
            //       child: const Text("Job Form",
            //           style: const TextStyle(color: Colors.white)),
            //       style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStatePropertyAll<Color>(Colors.lightBlue)),
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => JobForm()),
            //         );
            //       }),
            // ),
            SizedBox(
              width: 200,
              height: 42,
              child: TextButton(
                  child: const Text("Sign up",
                      style: const TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  }),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 42,
              child: TextButton(
                  child: const Text("Sign in",
                      style: const TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SigninPage()));
                  }),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 42,
              child: TextButton(
                  child: const Text("Test button",
                      style: const TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                  onPressed: () async {
                    await getApplicationsByListing(
                        "ccb2194d-b12d-4349-acc7-7933d3328971");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
