import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konet_app/model/order_model.dart';

// Kabul edilen ürünler için StateNotifier
class AcceptedProductsNotifier extends StateNotifier<List<OrderModel>> {
  AcceptedProductsNotifier() : super([]);

  // Listeye yeni ürün ekle ya da adeti güncelle
  void acceptProduct(OrderModel product) {
    final existingProduct = state.firstWhere(
      (item) => item.barkodNo == product.barkodNo,
      orElse: () => product.copyWith(orderPiece: "0"),
    );

    int? acceptedQuantity = int.tryParse(existingProduct.orderPiece ?? '0');
    if (acceptedQuantity != null && acceptedQuantity > 0) {
      // Ürün zaten varsa, adeti arttır
      state = state.map((item) {
        if (item.barkodNo == product.barkodNo) {
          return item.copyWith(orderPiece: (acceptedQuantity + 1).toString());
        }
        return item;
      }).toList();
    } else {
      // Ürün yoksa, yeni ürün olarak ekle
      state = [...state, product.copyWith(orderPiece: "1")];
    }
  }

  // Kabul edilen ürünleri temizle
  void clearAcceptedProducts() {
    state = [];
  }
}

// Kabul edilen ürünler için Provider
final acceptedProductsProvider = StateNotifierProvider<AcceptedProductsNotifier, List<OrderModel>>((ref) {
  return AcceptedProductsNotifier();
});
