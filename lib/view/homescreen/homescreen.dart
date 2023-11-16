import 'package:Firebase_auth/controller/auth_provider.dart';
import 'package:Firebase_auth/view/registernumber/register.dart';
import 'package:Firebase_auth/view/welcom/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authinitialpro =Provider.of<AuthentificationProvider>(context,listen: false);
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.blueGrey,
      title: const Text("Authenticators"),
      actions: [
        IconButton(onPressed: (){
          authinitialpro.userSignOut().then((value) =>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const WelcomeScreen())));
        }, 
        icon: const Icon(Icons.exit_to_app_outlined),
        ),
      ],
     ),
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
            backgroundImage: NetworkImage(authinitialpro.userModel.profilePic),
            radius: 50,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(authinitialpro.userModel.name),
          Text(authinitialpro.userModel.phoneNumber),
          Text(authinitialpro.userModel.email),
          Text(authinitialpro.userModel.bio)
        ],
      ),
     ),
    );
  }
}