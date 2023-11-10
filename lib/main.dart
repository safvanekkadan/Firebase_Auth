import 'package:Firebase_auth/view/welcom/welcome_screen.dart';


import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  runApp(const MainApp());

}


class MainApp extends StatelessWidget {

  const MainApp({super.key});


  @override

  Widget build(BuildContext context) {

    return const MaterialApp(

        debugShowCheckedModeBanner: false,

        title: 'Firebase Auth',

        home: WelcomeScreen());

  }

}

