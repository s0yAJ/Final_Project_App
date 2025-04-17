import 'package:flutter/material.dart';

PreferredSizeWidget DefensaAppBar(
    {required BuildContext context, VoidCallback? method}) {
  return AppBar(
    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.only(left: 21.0),
      child: Image.asset(
        'assets/banner.png',
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    ),
  );
}
