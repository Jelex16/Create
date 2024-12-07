import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard(
      {super.key, this.isRed = false, required this.text, this.onTap});
  final Function()? onTap;
  final bool isRed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              color:
                  isRed ? const Color.fromARGB(255, 205, 24, 221) : Colors.blue,
            ),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )));
  }
}
