import 'dart:ffi';

import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_model.g.dart'; //when that generator command is runnnig, as i add this .g.dart filean and saved, the studentmode.g.dart is generated succesfully

@HiveType(typeId: 3)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final categoryModel category;

  TransactionModel(
      {required this.purpose, required this.amount, required this.date,required this.category,required this.type});

  @override
  String toString() {
    return '{$purpose $amount $date $category}';
  }
}

//Code to build hte adapter file
// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs
