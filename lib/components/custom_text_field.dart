import 'package:comixnook_prj/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String hintText;

  CustomTextField({
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 19.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        filled: true,
        fillColor: Color(0x93EAD6FD),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: KPrimaryColor),
        ),
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 10.0),
          child: Icon(
            prefixIcon,
            color: KPrimaryColor,
            size: 25.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 18.0,
          color: Colors.black45,
        ),
      ),
    );
  }
}
