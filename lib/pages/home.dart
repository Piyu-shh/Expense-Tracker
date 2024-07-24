import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/pages/transaction_form.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void addNewExpense() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          constraints: BoxConstraints.expand(width: double.infinity),
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: TransactionForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add_chart_rounded),
                  onPressed: addNewExpense,
                  label: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                  child: Center(child: Text('Mode')),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.getExpenseList().length,
                itemBuilder: (context, index) {
                  final expense = value.getExpenseList()[index];
                  return ListTile(
                    leading: expense.icon,
                    trailing: Text(
                      (expense.type == "Income" ? "+" : "-") +
                          "${expense.amount}",
                      style: TextStyle(
                        color: expense.type == "Income"
                            ? Colors.green
                            : Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    title: Text(expense.name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
