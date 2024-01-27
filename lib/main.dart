import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();

	await Supabase.initialize(
		url: "https://vlfoxowrxwpwqyqmgdcq.supabase.co",
		anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsZm94b3dyeHdwd3F5cW1nZGNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYzNzI3NzAsImV4cCI6MjAyMTk0ODc3MH0.YXSiP29RnxBC5BDV0sP6AzF2NkLe0h15KuODJvtoLlo",
	);

	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
						const Text("Welcome to Scholarly"),
						TextButton(
							child: const Text("Sign up"),
							onPressed: () async {
								print("TODO!");
							}
						),
						TextButton(
							child: const Text("Sign in"),
							onPressed: () async {
								print("TODO!!!!");
							}
						)
          ],
        ),
      ),
    );
  }
}
