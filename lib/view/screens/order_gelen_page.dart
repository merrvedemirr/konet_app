import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konet_app/utils/utils.dart';
import 'package:konet_app/viewmodel/order_gelen_notifier.dart';
import 'package:konet_app/viewmodel/order_kabul_edilen_notifier.dart';

class OrderGelenPage extends ConsumerStatefulWidget {
  const OrderGelenPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderGelenPageState createState() => _OrderGelenPageState();
}

class _OrderGelenPageState extends ConsumerState<OrderGelenPage> {
  @override
  Widget build(BuildContext context) {
    // incomingProductsProvider'daki veriyi dinliyoruz
    final incomingItems = ref.watch(incomingProductsProvider);

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: incomingItems.length,
            itemBuilder: (context, index) {
              final product = incomingItems[index];
              return GestureDetector(
                onTap: () {
                  // Kabul edilen ürünler listesine ekle
                  ref.read(acceptedProductsProvider.notifier).acceptProduct(product);

                  // Gelen ürünler listesinden adeti azalt
                  int? currentQuantity = int.tryParse(product.orderPiece ?? '0');
                  if (currentQuantity != null && currentQuantity > 1) {
                    ref.read(incomingProductsProvider.notifier).decreaseProductQuantity(product);
                  } else {
                    // Eğer ürün adeti 1 ise tamamen kaldır
                    ref.read(incomingProductsProvider.notifier).removeProduct(product);
                  }
                },
                child: ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  title: Column(
                    children: [
                      Text(
                        product.orderName ?? "",
                        style: textStyle(context),
                      ),
                      Text(product.barkodNo ?? "", style: textStyle(context)),
                      Text(product.orderFiyat ?? "", style: textStyle(context)),
                    ],
                  ),
                  trailing: Text(
                    "${product.orderPiece ?? '0'} Adet",
                    style: textStyle(context),
                  ),
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
      ],
    );
  }
}
