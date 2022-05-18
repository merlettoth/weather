// Flutter imports:
import 'package:flutter/material.dart';

// показываем SnackBar с информацией об ошибке
void showErrorInfoSnackBar({required BuildContext context, required String text}) {
  const height = 40.0;
  final bodyHeight =
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
  final position = bodyHeight / 2 - height / 2;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: position, left: 20, right: 20),
      padding: EdgeInsets.zero,
      backgroundColor: Colors.redAccent.shade100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: SizedBox(
        height: height,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
