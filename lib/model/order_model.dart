class OrderModel {
  final String? orderName;
  final String? barkodNo;
  final String? orderFiyat;
  final String? orderPiece; // Gelen ürünlerin adeti nullable String olarak tutuluyor
  final String? siparisId;

  OrderModel(
      {required this.orderName,
      required this.barkodNo,
      required this.orderFiyat,
      required this.orderPiece,
      this.siparisId});

  // copyWith metodu
  OrderModel copyWith({
    String? orderName,
    String? barkodNo,
    String? orderFiyat,
    String? orderPiece,
  }) {
    return OrderModel(
      orderName: orderName ?? this.orderName,
      barkodNo: barkodNo ?? this.barkodNo,
      orderFiyat: orderFiyat ?? this.orderFiyat,
      orderPiece: orderPiece ?? this.orderPiece,
    );
  }

  // JSON'dan nesneye dönüştürme metodu
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderName: json['urun_adi'] as String?,
      barkodNo: json['urun_barkod'] as String?,
      orderFiyat: json['fiyat'] as String?,
      orderPiece: json['adet'] as String?,
      siparisId: json["siparis_id"] as String?,
    );
  }

  // Nesneyi JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'urun_adi': orderName,
      'urun_barkod': barkodNo,
      'fiyat': orderFiyat,
      'adet': orderPiece,
    };
  }
}
