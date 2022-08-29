// ignore_for_file: use_key_in_widget_constructors, duplicate_ignore, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;
  // ignore: prefer_const_constructors_in_immutables
  ChartBar(this.label, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(child: Text('₹${amount.toStringAsFixed(0)}'))),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            FractionallySizedBox(
              heightFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
