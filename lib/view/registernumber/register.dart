import 'package:Firebase_auth/constans/String.dart';
import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phonecontroller = TextEditingController();

  Country selectedcountry = Country(
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
    phonecontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: phonecontroller.text.length));
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.purple),
                child: Lottie.asset('assets/register.json'),
              ),
              kheight20,
              const Text(
                "Add your phone Number. We'll send you a verification code",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              kheight40,
              TextFormField(
                //   textInputAction:TextInputAction.none ,
                //  autocorrect: false,
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                cursorColor: Colors.blueGrey,
                controller: phonecontroller,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 3),
                onChanged: (value) {
                  setState(() {
                    phonecontroller.text = value;
                  });
                },
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.symmetric(vertical: 15),

                  hintText: ' Enter Phone number',
                  hintStyle: const TextStyle(letterSpacing: 0),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26)),
                  prefix: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 500),
                            onSelect: (value) {
                              setState(() {
                                selectedcountry = value;
                              });
                            });
                      },
                      child: Text(
                        "${selectedcountry.flagEmoji} +${selectedcountry.phoneCode}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  suffix: phonecontroller.text.length > 9
                      ? Container(
                          height: 20,
                          width: 20,
                          margin: EdgeInsets.only(
                              right: 5, bottom: 5, left: 5, top: 5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      : null,
                ),
              ),
              kheight20,
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
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
                    "Login",
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
}
