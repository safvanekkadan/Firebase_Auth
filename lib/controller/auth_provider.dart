import 'package:Firebase_auth/utils/utilities.dart';
import 'package:Firebase_auth/view/otpscreen/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isignedIn => _isSignedIn;
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

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

}

