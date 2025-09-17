import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _saveExpense() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }

    final expense = Expense(
      title: _titleController.text,
      amount: double.tryParse(_amountController.text) ?? 0,
      date: _selectedDate!,
    );

    Navigator.pop(context, expense);
  }

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDate: now,
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? "No Date Chosen"
                        : "Picked: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text("Choose Date"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveExpense,
              child: const Text("Save Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
