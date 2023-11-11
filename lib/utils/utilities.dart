import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String Content){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(Content))
  );
}