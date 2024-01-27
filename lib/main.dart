import 'package:flacktest/pages/navbar.dart';
import 'package:flacktest/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flacktest/pages/signup.dart';
import 'package:flacktest/pages/signin.dart';

import 'package:flacktest/backend/joblisting.dart';
import 'package:flacktest/backend/application.dart';

final supabase = Supabase.instance.client;

import 'package:flacktest/pages/jobform.dart';
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
				fontFamily: "Rubik",
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
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const OnboardingPage()),
          (_) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const MainScreenNav()),
          (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }
}
