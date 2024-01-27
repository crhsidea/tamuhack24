import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flacktest/pages/signup.dart';
import 'package:flacktest/pages/signin.dart';

import 'package:flacktest/backend/joblisting.dart';
import 'package:flacktest/backend/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://vlfoxowrxwpwqyqmgdcq.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsZm94b3dyeHdwd3F5cW1nZGNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYzNzI3NzAsImV4cCI6MjAyMTk0ODc3MH0.YXSiP29RnxBC5BDV0sP6AzF2NkLe0h15KuODJvtoLlo",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobJet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JobJet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text("Welcome to JobJet", style: TextStyle(fontSize: 25)),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 42,
                  child: TextButton(
                      child: const Text("Sign up",
                          style: const TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.lightBlue)),
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
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.lightBlue)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninPage()));
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
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.lightBlue)),
                      onPressed: () async {
                        await getListingsByUser(
                            "b95261fa-c289-499d-9f71-4fa6d8f5bce0");
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
