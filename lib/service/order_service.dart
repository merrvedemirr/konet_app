import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:konet_app/model/order_model.dart';

abstract class IOrderService {
  final Dio dio;

  IOrderService({required this.dio});

  Future<String?> fetchSiparisId();
  Future<List<OrderModel>?> fetchSiparisDetay(String siparisId);
  Future<bool> resetSiparisId();
  Future<bool> siparisTamamla(String siparisId);
}

class OrderService extends IOrderService {
  OrderService({required super.dio});

  @override
  Future<String?> fetchSiparisId() async {
    try {
      final response = await dio.post("/siparis_kontrol.php",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(response.data);
        inspect("data");
        inspect("data: $data");

        if (data['status'] == 'success') {
          final siparisId = data['siparis_id'];

          if (siparisId != null) {
            inspect('Gelen sipariş ID: $siparisId');
            return siparisId; // siparis_id'yi geri döndürüyoruz
          } else {
            inspect('Yeni sipariş bulunamadı.');
            return null; // Yeni sipariş yoksa null döndür
          }
        } else {
          inspect('İstek başarısız oldu.');
        }
      }
    } catch (e) {
      inspect("e:");
      inspect("e: $e");
      inspect('Bir hata oluştu: $e');
    }

    return null; // Hata oluşursa veya sipariş bulunamazsa null döndür
  }

  @override
  Future<List<OrderModel>?> fetchSiparisDetay(String siparisId) async {
    try {
      final response = await dio.post(
        "/siparis_detay.php",
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'siparis_id': siparisId, // siparis_id'yi POST isteği ile gönderiyoruz
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = await jsonDecode(response.data); // API'den gelen veriyi parse ediyoruz

        if (data != null && data["status"] == "success") {
          inspect('Sipariş Detayları: $data');

          // Gelen veri listesi olabilir, bunu kontrol ediyoruz ve OrderModel listesine çeviriyoruz
          List<dynamic> orderList = data["data"] ?? [];
          List<OrderModel> orderModels = orderList.map((order) => OrderModel.fromJson(order)).toList();

          return orderModels; // OrderModel listesi olarak dönüyoruz
        } else {
          inspect('Sipariş detayları status error geldi.');
          return null;
        }
      } else {
        inspect("Sunucu hatası: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      inspect('Bir hata oluştu: $e');
      return null;
    }
  }

  @override
  Future<bool> resetSiparisId() async {
    final response = await dio.post("/deneme_reset.php",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    if (response.statusCode == HttpStatus.ok) {
      inspect("isTrue");
      inspect("isTrue: $response");
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> siparisTamamla(String siparisId) async {
    try {
      final response = await dio.post(
        "/siparis_tamamla.php",
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'siparis_id': siparisId, // siparis_id'yi POST isteği ile gönderiyoruz
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        final data = await jsonDecode(response.data);

        if (data["status"] == "success") {
          if (siparisId != "null") {
            inspect("Sipariş tamamlandı");
            return true;
          }
        }
        return false;
      } else {
        inspect("Sipariş tamamlanamadı");
        return false;
      }
    } catch (e) {
      inspect("hata: $e");
      return false;
    }
  }
}
