import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      title: Text(
        widget.title, // Use widget.title to access the title property
        style: GoogleFonts.dynaPuff(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF66B2B2),
              Color(0xFF66B2B2),
            ],
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(11, 11),
          ),
        ),
      ),
    );
  }
}