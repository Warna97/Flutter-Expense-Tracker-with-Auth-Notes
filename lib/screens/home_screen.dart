import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),
      body: _expenses.isEmpty
          ? const Center(child: Text("No expenses yet"))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) =>
                  ExpenseTile(expense: _expenses[index]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add');
          if (result is Expense) _addExpense(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
