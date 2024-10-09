import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double smallestDimension;

  const CustomAppBar({super.key, required this.smallestDimension});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: smallestDimension * 0.18, // AppBar yüksekliği
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: SizedBox(
        height: smallestDimension * 0.18, // Logonun boyutu
        child: Image.asset("assets/jpg/konet_logo_white.png"),
      ),
    );
  }

  // AppBar'ın yüksekliği için bir zorunlu parametre
  @override
  Size get preferredSize => Size.fromHeight(smallestDimension * 0.18);
}
