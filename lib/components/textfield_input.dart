import 'package:alzheimer_app/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inputfield extends StatelessWidget {
  const Inputfield({
    super.key,
    required this.Controller,
    required this.labeltxt,
    required this.tap,
  });

  final TextEditingController Controller;
  final String labeltxt;
  final VoidCallback tap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: tap,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Red.withOpacity(0.5),
      ),
      cursorColor: Red,
      controller: Controller,
      decoration: InputDecoration(
        isDense: true,
        labelText: labeltxt,
        labelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkBlue.withOpacity(0.4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: darkBlue.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: darkBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
