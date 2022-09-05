import 'package:shopping_cart_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key, required this.buttonLabel, required this.onButtonTap})
      : super(key: key);
  final String buttonLabel;
  final Function onButtonTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonTap as void Function()?,
      child: Container(
        height: 48,
        width: 136,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: appPrimaryColor),
        child: Center(
          child: Text(
            buttonLabel,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
    // .onTap(onButtonTap);
  }
}
