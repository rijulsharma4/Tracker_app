import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  static const routeName = '/add-expense';

  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Add Expense Screen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('In Week 2, this will become a real form with validation.'),
          ],
        ),
      ),
    );
  }
}
