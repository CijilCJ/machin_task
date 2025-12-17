import 'package:flutter/material.dart';


// Form Field
Widget textFormField(
  controller,
  String labelText,
  IconData icon,
  Function validator,
  
) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      
      labelText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    validator: (value)=>validator(value),
  );
}


// Scafold Messenger
void showSnackBarMessage(BuildContext context, String message, ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}