// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double? width;
  final int? maxLines;
  const MyTextFields({
    super.key,
    required this.hintText,
    required this.controller,
    this.width, this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 0,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade400,
          )),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
