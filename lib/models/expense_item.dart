import 'package:flutter/material.dart';

class ExpenseItem {
  final String type;
  final Widget icon;
  final String name;
  final double amount;
  final DateTime dateTime;
  final String? description;

  ExpenseItem(
      {required this.type,
      required this.amount,
      required this.dateTime,
      required this.icon,
      required this.name,
      this.description});
}
