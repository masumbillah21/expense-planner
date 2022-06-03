import 'package:expanse_planner/models/transaction.dart';
import 'package:expanse_planner/widgets/new_transaction.dart';
import 'package:expanse_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Chocolate',
      amount: 1.13,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Chocolate',
      amount: 1.13,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Chocolate',
      amount: 1.13,
      date: DateTime.now(),
    ),
  ];
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
