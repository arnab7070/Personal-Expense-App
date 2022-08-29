// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element
import 'package:flutter/material.dart';
import 'models/transanction.dart';
import './new_transanction.dart';
import './transanctions_list.dart';
import 'package:flutter/services.dart';
import './chart.dart';

void main() {
  // We use it to force the app to work only in Portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transanction> _userTransactions = [];

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transanction(
      name: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transanction> get _recentTransaction {
    return _userTransactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontFamily: 'OpenSans', fontSize: 25, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add)),
        ],
        title: Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ignore: sized_box_for_whitespace
            Container(
              width: double.infinity,
              // height: 50,
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Chart(_recentTransaction),
            ),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        backgroundColor: Colors.teal,
        enableFeedback: true,
        elevation: 10,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
