import 'package:flutter/material.dart';

class CustomButtonG extends StatelessWidget {
  const CustomButtonG({
    super.key,
    this.onTap,
    required this.text,
    required this.color,
    this.colorText,
    this.number,
  });
  final void Function()? onTap;
  final String text;
  final Color color;
  final String? number;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        width: double.infinity,
        child: number == null
            ? Center(
                child: colorText != null
                    ? Text(text,
                        style: TextStyle(
                            color: colorText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
                    : Text(text,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
              )
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: colorText != null
                        ? Text(text,
                            style: TextStyle(
                                color: colorText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                        : Text(text,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                  ),
                  Align(alignment: Alignment.centerRight, child: _number()),
                ],
              ),
      ),
    );
  }

  Widget _number() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          number!,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
