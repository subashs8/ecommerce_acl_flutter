import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/themes/app_colors.dart';
import 'package:shopping_cart_app/screens/routes.dart';
import 'package:shopping_cart_app/screens/login.dart';
import 'package:shopping_cart_app/provider/cart_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: appPrimaryColor,
            primarySwatch: appPrimarySwatchColor,
          ),
          home: const LoginPage(),
          routes: Routes.routes,
        );
      }),
    );
  }
}


