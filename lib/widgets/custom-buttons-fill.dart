import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colours.dart';

class IconButtonWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const IconButtonWithText({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(color: Colours.palletRed, width: 3.0,)
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colours.palletBlue,),
          const SizedBox(width: 8), // Adjust the spacing between icon and text
          Text(text, style: TextStyle(
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colours.palletBlue
          ),
          )
        ],
      ),
    );
  }
}