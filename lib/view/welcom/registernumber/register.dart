import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/constans/String.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
final TextEditingController phonecontroller =TextEditingController();

  Country selectedcountry =Country(
    phoneCode: "91", 
    countryCode: "IN", 
    e164Sc: 0, 
    geographic: true, 
    level: 1, 
    name: "India", 
    example: "India", 
    displayName: "India", 
    displayNameNoCountryCode: "IN", 
    e164Key: "");

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child:Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical:25,horizontal: 35),
              child: Column(
                children: [
                 Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple
                  ),
                  child: Lottie.asset('assets/register.json'),
                 ),
                 kheight20,
                 Text("Add your phone Number. We'll send you a verification code",
                 style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                 ),
                 textAlign: TextAlign.center,),
                 kheight40,
                 TextFormField(
                  cursorColor: Colors.blueGrey,
                  controller:phonecontroller ,
                  decoration: InputDecoration(
                    helperText: 'Enter Phone number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26)
                    ),
                    prefix: Container(
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: (){
                          showCountryPicker(context: context , 
                          countryListTheme: CountryListThemeData(
                            bottomSheetHeight: 500
                          ),
                          onSelect: (value){setState(() {
                           selectedcountry=value;
                          });
                
                          });
                        },
                        child: Text("${selectedcountry.flagEmoji} +${selectedcountry.phoneCode}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:FontWeight.bold,
                          color: Colors.black
                        ),),
                      ),
                    )
                  ),
                

                 )

                ],
              ),),
        ) ),
    );
  }
}