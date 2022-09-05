import 'package:flutter/material.dart';
import 'package:shopping_cart_app/screens/product_detail.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
//    "/productDetail": (BuildContext context) =>
    "/productDetail": (BuildContext context) =>
        ProductDetailPage(),
  };
}