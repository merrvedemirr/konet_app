import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konet_app/constantsVariable/constance_variable.dart';
import 'package:konet_app/model/order_model.dart';
import 'package:konet_app/viewmodel/button_notification.dart';
import 'package:konet_app/viewmodel/order_kabul_edilen_notifier.dart';
import 'package:konet_app/widgets/order_list_card.dart';

class OrderKabulEdilen extends ConsumerWidget {
  const OrderKabulEdilen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kabul edilen ürünler listesini dinliyoruz
    final List<OrderModel> items = ref.watch(acceptedProductsProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 9,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              // Liste sonuna ulaşıldığında buton gösteriliyor
              if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                ref.read(completeButtonVisibilityProvider.notifier).showButton();
              }
              // Yukarı kaydırıldığında buton gizleniyor
              if (scrollNotification.metrics.pixels < scrollNotification.metrics.maxScrollExtent) {
                ref.read(completeButtonVisibilityProvider.notifier).hideButton();
              }
              return true;
            },
            child: OrderListCard(
              heightCard: MediaQuery.of(context).size.height * 0.70,
              textName: ConstanceVariable.orderKabul,
              orderList: items,
            ),
          ),
        ),
      ],
    );
  }
}
