import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/utils/money.dart';
import 'package:tracker_app/screens/add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _items = <Expense>[
    // Starter data (optional)
    Expense(id: '1', title: 'Coffee', amount: 4.50, date: DateTime.now(), currency: 'CAD'),
    Expense(id: '2', title: 'Groceries', amount: 62.99, date: DateTime.now(), currency: 'CAD'),
  ];

  Future<void> _goToAdd() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
    );
    if (result is Expense) {
      setState(() => _items.insert(0, result));
    }
  }

  String _dateLabel(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tracker')),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No expenses yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final e = _items[i];
                return Dismissible(
                  key: ValueKey(e.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    final removed = e;
                    setState(() => _items.removeAt(i));
                    // (Optional) Undo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleted "${removed.title}"'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            setState(() => _items.insert(i, removed));
                          },
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(e.title),
                    subtitle: Text(_dateLabel(e.date)),
                    trailing: Text(formatMoney(e.amount, e.currency)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
