import 'package:Firebase_auth/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../constans/String.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key,
  required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String?otpCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: ()=> Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back),
                ),
              ),

              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.purple),
                child: Lottie.asset('assets/register.json'),
              ),
              kheight20,
              const Text("Verification",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              ),
              kheight20,
              const Text(
                "Enter the OTP send to your phone number",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              kheight20,
              Pinput(
                length :6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple
                  )
                ),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,

                ),
              ),
              onSubmitted:(value){
                setState(() {
                  otpCode=value;
                });
              } ,
              
              ),
              kheight20,
              Padding(
               padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: (){
                      if(otpCode!=null){
                        verifyOtp(context,otpCode!);
                      }else{
                        showSnackBar(context, "Enter 6-Digit code");
                      }
                    },
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
                      "Verify",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              kheight20,
              const Text(
                "Didn't recieve any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              kheight20,
              const Text(
                "Resend OTP",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
                ),
              )
             ]
            ),
           ),
         )
       ),
      
    );
  }
  //otp
  void verifyOtp(BuildContext context ,String userotp){

  }
}