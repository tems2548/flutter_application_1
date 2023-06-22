import 'package:flutter/material.dart';

// example widget box

class BoxWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final double size;

  // ignore: empty_constructor_bodies
  const BoxWidget(
      {super.key,
      required this.title,
      required this.amount,
      required this.color,
      required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              amount.toString(),
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
