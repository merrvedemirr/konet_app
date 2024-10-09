import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konet_app/model/order_model.dart';
import 'package:konet_app/service/order_service.dart';
import 'package:konet_app/service/project_dio_mixin.dart';

class IncomingProductsNotifier extends StateNotifier<List<OrderModel>> with ProjectDioMixin {
  late final OrderService orderService;
  String? _siparisId;

  IncomingProductsNotifier() : super([]) {
    orderService = OrderService(dio: servicePath);
  }
  String get siparisId => _siparisId ?? "null";

  // API'den siparişleri çek ve durumu güncelle
  Future<void> fetchOrders() async {
    try {
      var isReset = await orderService.resetSiparisId();
      if (isReset) {
        final siparisId = await orderService.fetchSiparisId();
        if (siparisId != null) {
          _siparisId = siparisId;
          final siparisDetaylari = await orderService.fetchSiparisDetay(siparisId);
          if (siparisDetaylari != null) {
            state = siparisDetaylari;
          }
        }
      }
    } catch (e) {
      inspect('Bir hata oluştu: $e');
    }
  }

  // Gelen ürünler listesinden ürünün adetini azalt
  void decreaseProductQuantity(OrderModel product) {
    int? currentQuantity = int.tryParse(product.orderPiece ?? '0');
    if (currentQuantity != null && currentQuantity > 1) {
      // Ürünün adeti 1'den fazla ise azalt
      state = state.map((item) {
        if (item == product) {
          return item.copyWith(orderPiece: (currentQuantity - 1).toString());
        }
        return item;
      }).toList();
    } else {
      // Eğer adet 1 veya null ise ürünü tamamen kaldır
      removeProduct(product);
    }
  }

  // Gelen ürünler listesinden ürünü tamamen kaldır
  void removeProduct(OrderModel product) {
    state = state.where((item) => item != product).toList();
  }
}

// Gelen ürünler için Provider
final incomingProductsProvider = StateNotifierProvider<IncomingProductsNotifier, List<OrderModel>>((ref) {
  return IncomingProductsNotifier();
});

final siparisIdProvider = StateProvider<String?>((ref) => null);
