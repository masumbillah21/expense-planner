import 'package:expanse_planner/models/transaction.dart';
import 'package:expanse_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        var total = 0.00;

        for (var tx in recentTransactions) {
          if (tx.date.day == weekDay.day &&
              tx.date.month == weekDay.month &&
              tx.date.year == weekDay.year) {
            total += tx.amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': total
        };
      },
    );
  }

  double get maxSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'], data['amount'], data['amount'] / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
