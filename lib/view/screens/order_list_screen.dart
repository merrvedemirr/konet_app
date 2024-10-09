import 'package:flutter/material.dart';
import 'package:konet_app/constantsVariable/constance_variable.dart';
import 'package:konet_app/view/screens/order_gelen_page.dart';
import 'package:konet_app/view/screens/order_kabul_edilen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderLisrScreenState();
}

class _OrderLisrScreenState extends State<OrderListScreen> {
  final List<Tab> mytabs = <Tab>[
    const Tab(
      text: ConstanceVariable.orderGelen,
    ),
    const Tab(
      child: Text(
        ConstanceVariable.orderKabul,
        textAlign: TextAlign.center,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // En küçük boyutu hesaplayın (genişlik veya yükseklik)
    final double smallestDimension = screenWidth < screenHeight ? screenWidth : screenHeight;
    return DefaultTabController(
        length: mytabs.length,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            toolbarHeight: smallestDimension / 5, // AppBar yüksekliği
            title: SizedBox(
              height: smallestDimension * 0.18,
              child: Image.asset(
                "assets/jpg/konet_logo_white.png",
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                splashBorderRadius: BorderRadius.circular(20),
                dividerHeight: 0,
                labelColor: Colors.white,
                labelStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(),
                unselectedLabelColor: ConstanceVariable.buttonColor,
                indicator: ShapeDecoration(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: ConstanceVariable.buttonColor),
                tabs: mytabs),
          ),
          body: const TabBarView(children: [OrderGelenPage(), OrderKabulEdilen()]),
        )));
  }
}

//? DUMMY CLASS
// class OrderItems {
//   late final List<OrderModel> items;

//   OrderItems() {
//     items = [
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "100"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "100"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "100"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "100"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200"),
//       OrderModel(orderName: "Ürün Adı", barkodNo: "Barkodu", orderFiyat: "Türü", orderPiece: "200")
//     ];
//   }
// }
