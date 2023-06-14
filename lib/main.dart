import 'package:ethicalfitness_2/event_provider.dart';
import 'package:ethicalfitness_2/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//class MyApp extends StatelessWidget {
//  const MyApp({Key? key}) : super(key: key);
//  @override
//  Widget build(BuildContext context) => ChangeNotifierProvider(
//        create: (context) => EventProvider(),
//        child: const MaterialApp(
//          debugShowCheckedModeBanner: false,
//          home: MainPage(),
//        ),
//      );
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
