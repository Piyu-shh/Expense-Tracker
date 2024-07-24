import 'package:flutter/material.dart';

class Transaction {
  final String type;
  final IconData icon;
  final String name;
  final double amount;
  final DateTime dateTime;
  final String description;

  Transaction(this.dateTime, this.description,
      {required this.type,
      required this.icon,
      required this.name,
      required this.amount});
}
