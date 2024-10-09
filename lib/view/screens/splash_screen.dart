import 'dart:async';

import 'package:flutter/material.dart';
import 'package:konet_app/view/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //todo:yönlendirme yapılıyor fakat doğrulamalar yapılamdı henüz
  void _navigate() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false));
  }

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Image.asset(
                  "assets/jpg/backgroundImage.jpg",
                  width: screenWidth,
                  height: screenHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: screenHeight * 0.3, // Ekranın %30 yukarısına konumlandırma
                  left: (screenWidth - screenWidth * 0.6) / 2, // Logoyu ortalamak için
                  child: Image.asset(
                    'assets/jpg/konet_logo_white.png', // Logonuzun yolu
                    width: screenWidth * 0.6, // Ekran genişliğine göre logonun boyutunu ayarlıyoruz
                    fit: BoxFit.contain, // Logoyu ekrana uygun şekilde sığdırıyoruz
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
