import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';

const supportedCurrencies = <String>['USD','CAD','EUR','GBP','INR','JPY','AUD'];

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime? _date;
  String _currency = 'CAD';

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _submit() {
    final title = _titleCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text.trim());
    final date = _date;

    final errors = <String>[];
    if (title.isEmpty) errors.add('Title is required');
    if (amount == null || amount <= 0) errors.add('Amount must be > 0');
    if (date == null) errors.add('Please pick a date');

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors.join(' • '))),
      );
      return;
    }

    final expense = Expense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      amount: amount!, // safe after validation
      date: date!,     // safe after validation
      currency: _currency,
    );

    Navigator.pop(context, expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _amountCtrl,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickDate,
                    child: Text(
                      _date == null
                          ? 'Pick Date'
                          : '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _currency,
                    items: supportedCurrencies
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _currency = v ?? 'CAD'),
                    decoration: const InputDecoration(labelText: 'Currency'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
