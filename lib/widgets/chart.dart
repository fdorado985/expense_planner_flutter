import 'package:expense_planner_flutter/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get _totalSpending {
    return _groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Chart({@required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    print(_groupedTransactionValues);
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'],
              data['amount'],
              _totalSpending == 0.0
                  ? 0.0
                  : (data['amount'] as double) / _totalSpending,
            ),
          );
        }).toList(),
      ),
    );
  }
}
