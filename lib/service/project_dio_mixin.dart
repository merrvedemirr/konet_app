import 'package:dio/dio.dart';

//Bu class bir parametre almaz sadece bu değer kullanılır. diğer classlara with şeklinde eklenir.
mixin ProjectDioMixin {
  final servicePath = Dio(BaseOptions(baseUrl: "https://medmate.com.tr/konet/api"));
}
