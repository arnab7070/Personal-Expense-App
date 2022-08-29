// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime? _dateSelector;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (_amountController.text.isEmpty) {
      return;
    }
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _dateSelector == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _dateSelector,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _dateSelector = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dateSelector == null
                        ? 'No Date Chosen!'
                        : DateFormat.yMMMEd()
                            .format(_dateSelector ?? DateTime.now()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: _presentDatePicker,
                    textColor: Colors.green,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'OpenSans-Regular',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              // ignore: sort_child_properties_last
              child: Text('Add Transaction'),
              color: Colors.amber,
              textColor: Colors.red,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
