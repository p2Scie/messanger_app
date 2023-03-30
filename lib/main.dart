import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messanger_app/view/auth_page.dart';
import 'firebase_options.dart';
import 'package:google_ml_kit/google_ml_kit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messanger Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Messanger'),
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
  //Variables 
  late TextEditingController controller;
  late LanguageIdentifier identifer;


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Messanger Chat",
      debugShowCheckedModeBanner: false,
      home: AuthPage() 
    );
  }
}
