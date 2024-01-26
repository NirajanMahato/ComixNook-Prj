import 'package:comixnook_prj/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final TextInputType keyboardType;
  final IconData prefixIcon;

  PasswordTextField({
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.keyboardType,
    required this.prefixIcon,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 16.0,
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
            widget.prefixIcon,
            color: KPrimaryColor,
            size: 25.0,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 17.0,
          color: Colors.black45,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 25.0),
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              size: 24.0,
              color: KPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
