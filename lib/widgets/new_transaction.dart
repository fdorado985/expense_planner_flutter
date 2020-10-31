import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function onPressedNewTransaction;

  NewTransaction({@required this.onPressedNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              onPressed: () => onPressedNewTransaction(
                  titleController.text, double.parse(amountController.text)),
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}