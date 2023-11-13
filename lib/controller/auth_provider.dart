import 'package:Firebase_auth/utils/utilities.dart';
import 'package:Firebase_auth/view/otpscreen/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isignedIn => _isSignedIn;
    bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid=> _uid!;
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
 final FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  AuthentificationProvider(){
    checksign();
  }
  
  void checksign()async {
  final SharedPreferences s =await SharedPreferences.getInstance();
  _isSignedIn =s.getBool("is_signedin")?? false;
  notifyListeners();
  
}

void singWithPhone(BuildContext context,String phoneNumber)async{
  try{
  await _firebaseAuth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
  verificationCompleted: 
  (PhoneAuthCredential phoneAuthCredential)async{
    await _firebaseAuth.signInWithCredential(phoneAuthCredential);
  }, 
  verificationFailed: (error){
    throw Exception(error.message);
  }, 
  codeSent: (verificationId,forceResendingToken){
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>OtpScreen(verificationId: verificationId)));
  }, 
  codeAutoRetrievalTimeout: (verificationId){}
  );
  }on FirebaseAuthException catch(e){
    showSnackBar(context,e.message.toString());
  }
}

void verifyOtp({
  required BuildContext context,
  required String verificationId,
  required String userOtp,
  required Function onSuccess
}) async{
 _isLoading =true;
 notifyListeners();
 try{
  PhoneAuthCredential creds =PhoneAuthProvider.credential(
  verificationId: verificationId, 
  smsCode: userOtp);
  User? user=(await _firebaseAuth.signInWithCredential(creds)).user!;
  if(user!= null){
  _uid =user.uid;
   onSuccess();
  }
  _isLoading =false;
 }on FirebaseException catch(e){
  showSnackBar(context,e.message.toString());
 }
}


//database

Future<bool> checkExitingUser()async{
  DocumentSnapshot snapshot= await _firebaseFirestore.collection("users").doc(_uid).get();

  if(snapshot.exists){
    print("USER EXIST");
    return true;
  }else{
     print(" NEw USER ");
    return false;
  }
}
}

