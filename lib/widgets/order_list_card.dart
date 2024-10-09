import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konet_app/constantsVariable/constance_variable.dart';
import 'package:konet_app/model/order_model.dart';
import 'package:konet_app/service/order_service.dart';
import 'package:konet_app/service/project_dio_mixin.dart'; // Mixin'i dahil ettik
import 'package:konet_app/utils/utils.dart';
import 'package:konet_app/viewmodel/order_gelen_notifier.dart';
import 'package:konet_app/viewmodel/order_kabul_edilen_notifier.dart';
import 'package:konet_app/widgets/update_dialog.dart';

class OrderListCard extends ConsumerWidget with ProjectDioMixin {
  OrderListCard({
    super.key,
    required this.orderList,
    required this.textName,
    required this.heightCard,
  });

  final List<OrderModel> orderList;
  final String textName;
  final double heightCard;

  // Mixin ile servicePath'i kullanıyoruz
  late final IOrderService orderService = OrderService(dio: servicePath);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // incomingProductsProvider'daki veriyi dinliyoruz
    final incomingItems = ref.watch(incomingProductsProvider);

    return Card(
      child: SizedBox(
        height: heightCard,
        child: ListView.separated(
          itemCount: orderList.isEmpty ? 0 : orderList.length + 1, // Eğer liste boşsa butonu eklemiyoruz
          itemBuilder: (context, index) {
            // Eğer listede son elemandaysak ve liste boş değilse, buton gösterilecek
            if (index == orderList.length && orderList.isNotEmpty) {
              // Gelen ürünler boş ise tamamla butonunu gösteriyoruz
              if (incomingItems.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Siparişi tamamlama işlemi
                        final isTrue =
                            await orderService.siparisTamamla(ref.read(incomingProductsProvider.notifier).siparisId);

                        // Eğer sipariş başarılı değilse işlem yap
                        if (isTrue) {
                          // Ürünleri temizle
                          ref.read(acceptedProductsProvider.notifier).clearAcceptedProducts();

                          // Başarı mesajı göster
                          showUpdateDialog(context, ConstanceVariable.success, isOkey: true);
                        } else {
                          //Bir hata oluşursa
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Hata"),
                                content: Text(
                                  "Ürünler kabul edilirken hata oluştu", // Hatanın detaylarını göstermek için
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: buttonStyle(10, 20),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Dialogu kapat
                                    },
                                    child: const Text(
                                      'Tamam',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        inspect("Hata oluştu: $e");
                      }
                    },
                    style: buttonStyle(10, 80),
                    child: Text(
                      "Tamamla",
                      style: textStyle(context),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink(); // Eğer liste boş değilse buton gösterilmez
              }
            }

            // Diğer list elemanları
            return ListTile(
              leading: Text(
                "${index + 1}",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              title: Column(
                children: [
                  Text(
                    orderList[index].orderName ?? "",
                    style: textStyle(context),
                  ),
                  Text(
                    orderList[index].barkodNo ?? "",
                    style: textStyle(context),
                  ),
                  Text(
                    orderList[index].orderFiyat ?? "",
                    style: textStyle(context),
                  ),
                ],
              ),
              trailing: Text(
                "${orderList[index].orderPiece} Adet",
                style: textStyle(context),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
              thickness: 2,
            );
          },
        ),
      ),
    );
  }
}
