import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transanction.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:personal_expenses/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transanction> recentTransactions;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupTransaction.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      // ignore: prefer_const_constructors
      margin: EdgeInsets.all(8),
      child: Container(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: groupTransaction.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (data['day'] as String),
                (data['amount'] as double),
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
