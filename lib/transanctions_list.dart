// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../models/transanction.dart';

class TransactionList extends StatelessWidget {
  final List<Transanction> transactions;
  final Function deleteTx;
  // ignore: use_key_in_widget_constructors
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: [
                Text('No Transactions',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontFamily: 'OpenSans-Regular',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                Image.asset('assets/images/image.png'),
              ],
            )
          : Column(
              children: transactions.map((tx) {
                return Card(
                  elevation: 2,
                  shadowColor: Colors.deepOrangeAccent,
                  // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.deepOrangeAccent,
                          //     width: 2,
                          //   ),
                          // ),
                          // padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.tealAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  '₹${tx.amount}',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.name,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(tx.date),
                            style: TextStyle(
                              fontFamily: 'Quicksand-Bold',
                              fontSize: 16,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTx(tx.id),
                          ),
                          // ignore: deprecated_member_use
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
