import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black12,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        side: BorderSide(color: Colors.white),
      ),
    ),
  );
}