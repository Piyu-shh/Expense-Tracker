//import 'dart:ffi';

import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final List<Widget> _type = [Text('Income'), Text('Expense')];
  final List<bool> _selectedType = [false, true];
  final List<Widget> incomeIcon = [
    Icon(Icons.candlestick_chart_rounded),
    Icon(Icons.card_travel),
    Icon(Icons.computer_rounded),
    Icon(Icons.money_rounded),
    Icon(Icons.wallet_giftcard_rounded),
    Icon(Icons.star_rounded),
  ];
  final List<Widget> expenseIcon = [
    Icon(Icons.directions_car_rounded),
    Icon(Icons.handyman_rounded),
    Icon(Icons.person_add_rounded),
    Icon(Icons.local_pizza_rounded),
    Icon(Icons.house_rounded),
    Icon(Icons.star_rounded),
  ];
  final List<bool> _selectedIncomeIcon = [
    false,
    false,
    false,
    false,
    false,
    true,
  ];
  final List<bool> _selectedExpenseIcon = [
    false,
    false,
    false,
    false,
    false,
    true,
  ];

  List<Widget> iconList = [];
  List<bool> selectediconList = [];

  @override
  void initState() {
    super.initState();
    // Initial icon list and selected icons
    iconList = expenseIcon;
    selectediconList = _selectedExpenseIcon;
  }

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitTransaction() {
    final String type = _selectedType[0] ? 'Income' : 'Expense';
    final int selectedIndex =
        selectediconList.indexWhere((selected) => selected);
    if (selectedIndex == -1) return; // No icon selected

    final Widget icon = iconList[selectedIndex];
    final String name = _nameController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0;

    if (name.isEmpty || amount <= 0) {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please provide a valid name and amount.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final transaction = ExpenseItem(
      type: type,
      icon: icon,
      name: name,
      amount: amount,
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(transaction);
    Navigator.of(context).pop(); // Close the bottom sheet
  }

  MaterialColor color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          children: _type,
          isSelected: _selectedType,
          direction: Axis.horizontal,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          selectedBorderColor: color[600],
          selectedColor: Colors.white,
          fillColor: color[400],
          color: color[400],
          constraints: const BoxConstraints(minHeight: 40.0, minWidth: 150.0),
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _type.length; i++) {
                _selectedType[i] = i == index;
              }

              if (index == 0) {
                color = Colors.green;
                iconList = incomeIcon;
                selectediconList = _selectedIncomeIcon;
              } else {
                color = Colors.red;
                iconList = expenseIcon;
                selectediconList = _selectedExpenseIcon;
              }
            });
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              isSelected: selectediconList,
              selectedBorderColor: color,
              borderColor: Colors.grey,
              fillColor: Colors.transparent,
              constraints:
                  const BoxConstraints(minHeight: 40.0, minWidth: 40.0),
              selectedColor: color,
              borderWidth: 1,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              renderBorder: true,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < iconList.length; i++) {
                    selectediconList[i] = i == index;
                  }
                });
              },
              children: iconList.map((icon) => icon as Icon).toList(),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250.0, // Adjust width as needed
          height: 60.0, // Set height to 60
          child: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Transaction Name',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.grey, // Adjust color as needed
                  width: 0.5, // Set border width to 0.5 for thinner outline
                ),
              ),
            ),
            onChanged: (value) => setState(() {}),
            style: const TextStyle(fontSize: 16.0),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(
          width: 135.0, // Adjust width as needed
          child: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            onChanged: (value) => setState(() {}),
            style: const TextStyle(fontSize: 16.0),
            decoration: InputDecoration(
              hintText: 'Enter Amount',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.grey, // Adjust color as needed
                  width: 1.0, // Set border width to 1.0 for thinner outline
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 150.0, // Adjust width as needed
          height: 50.0, // Adjust height as needed
          child: ElevatedButton(
            onPressed: _submitTransaction,
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: color[400], // Adjust button color as needed
              padding: const EdgeInsets.symmetric(
                vertical: 15.0, // Adjust padding as needed
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
