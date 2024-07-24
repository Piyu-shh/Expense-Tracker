import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expenses

  List<ExpenseItem> overallExpenseList = [];

  //get expense list

  List<ExpenseItem> getExpenseList() {
    return overallExpenseList;
  }

  //add new expense

  void addNewExpense(ExpenseItem Expense) {
    overallExpenseList.add(Expense);
    notifyListeners();
  }

  //delete expense

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
  }

  //get weekday

  List<String> _weeks = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String getDayName(DateTime dateTime) {
    return (_weeks[dateTime.weekday - 1]);
  }

  //get date for start of week(sunday)
  DateTime? startOfWeekDate() {
    DateTime? startOfWeek;

    //todays date
    DateTime today = DateTime.now();

    //go backwards towards nearest sunday

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek;
  }

  // get date of start of month
  DateTime startOfMonth() {
    DateTime startOfMonth;

    DateTime today = DateTime.now();

    startOfMonth = today.subtract(Duration(days: today.day));

    return startOfMonth;
  }

  //daily expense summary

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount as String);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }

  //weekly expense suammry

  //monthly expesnse summary
}
