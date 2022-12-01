import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required TextEditingController controller,
      required this.hintText,
      required this.icon,
      required this.type,
      this.obscure = false})
      : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String hintText;
  final IconData icon;
  final TextInputType type;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Form(
        child: TextField(
          keyboardType: type,
          controller: _controller,
          obscureText: obscure,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
            prefixIconColor: foregroundColor,
            prefixIcon: Icon(
              icon,
              color: secondaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
