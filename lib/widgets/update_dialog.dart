import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konet_app/constantsVariable/constance_variable.dart';
import 'package:konet_app/service/project_dio_mixin.dart';
import 'package:konet_app/utils/utils.dart';
import 'package:konet_app/view/screens/main_screen.dart';
import 'package:konet_app/view/screens/order_list_screen.dart';
import 'package:konet_app/viewmodel/order_gelen_notifier.dart';
import 'package:konet_app/viewmodel/order_kabul_edilen_notifier.dart'; // Flag provider'ı ekliyoruz

class UpdateDialog extends ConsumerWidget with ProjectDioMixin {
  final String message;
  final bool isOkey;

  UpdateDialog({
    super.key,
    required this.message,
    this.isOkey = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
      ),
      contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        isOkey
            ? const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 50,
              )
            : ElevatedButton(
                onPressed: () {
                  ref.read(incomingProductsProvider.notifier).fetchOrders();
                  ref.read(acceptedProductsProvider.notifier).clearAcceptedProducts();
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const OrderListScreen();
                    },
                  )); // Manuel kapatma
                },
                style: buttonStyle(20, 50),
                child: Text(
                  ConstanceVariable.orderYes,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
      ],
    );
  }
}

Future<void> showUpdateDialog(BuildContext context, String message, {bool isOkey = false}) {
  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return UpdateDialog(message: message, isOkey: isOkey);
    },
  ).then((_) {
    // Eğer tamamlandı ikonu gösterildiyse
    if (isOkey) {
      // Dialog kapandıktan sonra yönlendirme yapıyoruz
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (route) => false,
      ); // Buraya yönlendirmek istediğiniz sayfa
    }
  });
}
