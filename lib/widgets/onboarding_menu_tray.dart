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
              height: 60,
              child: TextButton(
                  child: const Text("Let's make one!",
                      style: const TextStyle(color: Colors.white, fontSize: 18.0)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFF065A82))),
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
              height: 60,
              child: TextButton(
                  child: const Text("I've got one!",
                      style: const TextStyle(color: Colors.white,fontSize: 18.0)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFF91A6FF))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SigninPage()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
