import 'package:flutter/material.dart';
import 'package:konet_app/constantsVariable/constance_variable.dart';
import 'package:konet_app/customPadding/custom_padding.dart';
import 'package:konet_app/widgets/custom_appbar.dart';

import '../../utils/utils.dart';
import '../../widgets/update_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // En küçük boyutu hesaplayın (genişlik veya yükseklik)
    final double smallestDimension = screenWidth < screenHeight ? screenWidth : screenHeight;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(smallestDimension: smallestDimension),
        body: Center(
            child: Padding(
          padding: CustomPadding.medium.padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: CustomPadding.medium.paddingVertical,
                width: smallestDimension * 0.7,
                child: ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle(40, 50),
                  child: Text(
                    ConstanceVariable.stockManagement,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: smallestDimension * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    showUpdateDialog(context, ConstanceVariable.newOrder);
                  },
                  style: buttonStyle(40, 50),
                  child: Text(
                    ConstanceVariable.orderManagement,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
