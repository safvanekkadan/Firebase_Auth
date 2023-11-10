import 'package:Firebase_auth/constans/String.dart';
import 'package:Firebase_auth/view/registernumber/register.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 10),
            child: Lottie.asset('assets/welcome.json'),
          ),
          const Text(
            "Let's get started",
            style: srtstyle,
          ),
          kheight,
          const Text("Never a better time than now to start"),
          kheight40,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: const Text("Gets started "),
          ),
        ],
      ),
    );
  }
}
