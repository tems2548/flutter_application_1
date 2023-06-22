import 'package:flutter/material.dart';

// example widget box

class BoxWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final double size;
  final Color textcolor;
  final double fontsized;
  final String si;
  final double amoutsize;

  // ignore: empty_constructor_bodies
  const BoxWidget(
      {super.key,
      required this.title,
      required this.amount,
      required this.color,
      required this.size,
      required this.textcolor,
      required this.fontsized,
      this.si = "",
      this.amoutsize = 50});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 3.0)),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontsized,
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              amount.toString(),
              style: TextStyle(
                fontSize: amoutsize,
                color: textcolor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              si,
              style: TextStyle(
                fontSize: 30,
                color: textcolor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
