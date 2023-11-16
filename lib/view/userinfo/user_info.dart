import 'dart:io';

import 'package:Firebase_auth/model/user_model.dart';
import 'package:Firebase_auth/utils/utilities.dart';
import 'package:Firebase_auth/view/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  File? image;
  final nameController =TextEditingController();
  final emailController =TextEditingController();
  final bioController =TextEditingController();
  @override

  void dispose(){
   super.dispose();
   nameController.dispose();
   emailController.dispose();
   bioController.dispose();
  }
  void selectImage()async{
    image =await pickImage(context);
    setState(() {
      
    });
  }
  Widget build(BuildContext context) {
           final isLoading =Provider.of<AuthentificationProvider>(context,listen: true).isLoading;

    return Scaffold(
      body: SafeArea(
        child:isLoading== true
        ?const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        )
        : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 5),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: ()=>selectImage(),
                  child: image==null? const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 50,
                    child: Icon(Icons.account_circle,
                    size: 50,
                    color: Colors.white,),
                  )
                  :
                  CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 50,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      //name
                      TextField(
                        controller:nameController ,
                        hintText: "Your name",
                        icon: Icons.account_circle,
                        inputType:TextInputType.name ,
                        maxLines:1 ),
                        //email
                         TextField(
                        controller:emailController ,
                        hintText: "examble@gmail.com",
                        icon: Icons.email,
                        inputType:TextInputType.emailAddress ,
                        maxLines:1 ),
                        //bio
                         TextField(
                        controller:bioController ,
                        hintText: "Your bio...!",
                        icon: Icons.edit,
                        inputType:TextInputType.name ,
                        maxLines:2 )
                      
                    ],
                  ),
                ),
                 SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: ()=>StoreData(),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        )),
      
    );
  }
  Widget TextField({
     required String hintText,
     required IconData icon,
     required TextInputType inputType,
     required TextEditingController controller,
     required int maxLines,
    }){
    return  Padding(
      padding:const  EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin:const  EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple,
            ),
            child: Icon(icon,
            size: 20,
            color: Colors.purple,),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent
            ),
          ),
           focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple,
          filled: true
        ),
      ),
      );
  }
  //store database

  void StoreData()async{
     final authinitialpro =Provider.of<AuthentificationProvider>(context,listen: false);
     UserModel userModel =UserModel(
      name: nameController.text.trim(), 
      email: emailController.text.toString(), 
      bio: bioController.text.toString(), 
      profilePic: "", 
      createdAt: "", 
      phoneNumber: "", 
      uid: "",
      );
      if(image!=null){
authinitialpro.saveUserDataToFirebase(
  context: context, 
  userModel: userModel, 
  profilePic: image!, 
  onSuccess: (){
   //once data saved store locally also
   authinitialpro.saveUserDatasharedpreference().then((value) =>authinitialpro.setSignIn().then((value) => 
   Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context)=>
    const HomeScreen()), (route) => false))); 
  });
      }else{
        showSnackBar(context, "Please upload your profile photo");
      }

  }
}