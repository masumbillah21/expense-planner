import 'package:expanse_planner/models/transaction.dart';
import 'package:expanse_planner/widgets/chart.dart';
import 'package:expanse_planner/widgets/new_transaction.dart';
import 'package:expanse_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Keeper',
      theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: const TextTheme(
            headline6: TextStyle(
              fontSize: 20.0,
              fontFamily: 'OpenSans',
            ),
            headline2: TextStyle(
              fontSize: 16.0,
              fontFamily: 'OpenSans',
              color: Colors.red,
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Quicksand',
              color: Colors.black54,
            ),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction({required String txTitle, required double txAmount}) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(
            _addNewTransaction,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Keeper',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            tooltip: 'Add New',
            onPressed: () => _showTransactionModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: _recentTransactions.isEmpty
                  ? const Text('')
                  : Chart(_recentTransactions),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionModal(context),
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
