import 'dart:convert';
import 'package:shopping_cart_app/screens/login.dart';
import 'package:shopping_cart_app/themes/app_colors.dart';
import 'package:shopping_cart_app/components/button_widget.dart';
import 'package:shopping_cart_app/themes/app_colors.dart';
import 'package:shopping_cart_app/xhr/api_layer.dart';
import 'package:shopping_cart_app/xhr/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart_app/screens/product_list.dart';
import 'package:shopping_cart_app/screens/product_detail.dart';
import 'package:shopping_cart_app/screens/routes.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _doLogin() async {
    // validate forms and connect with api here. on success navigate to dashboard
    if(nameController.text == "" || passwordController.text == "") {
      // show proper toast message here
      return false;
    }

    var body = {
      "mail": nameController.text,
      "password": passwordController.text
    };

    Map<String, dynamic> endpoint = Endpoints.buildServiceUrl('post', 'login');

    await APIInterface.call(endpoint["method"], endpoint["url"], {}, jsonEncode(body)).then((value) {
      var res = jsonDecode(value);
      if(res["token"] != "") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductList()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'LEGO Store',
                    style: TextStyle(
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  )),
              const SizedBox(height: 8,),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              AppButton(
                  buttonLabel: "Sign Up",
                  onButtonTap: () => _doLogin()
              ),
              // onButtonTap: () {
              //   _doLogin();
              // }),
              const SizedBox(height: 4,),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Sign In',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
