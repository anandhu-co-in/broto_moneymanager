import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:brot_moneymanagementapp/db/models/transactions/transaction_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';

ValueNotifier<List<categoryModel>> studentListNotifier = ValueNotifier([]);

abstract class TransactionDBFunctions {
  Future<List<TransactionModel>> getTransactions();
  Future<void> addTrasaction(TransactionModel value);
  Future<void> deleteTransaction(int key);
}

class TransactionDB implements TransactionDBFunctions {
  // Below chunk of code makes this class singletone, (same as we done in CategryDB())
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactions = ValueNotifier([]);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final db = await Hive.openBox<TransactionModel>('transaction_db');
    print('RETREIVED ALL CATEGOEIES FROM DB');
    return db.values.toList();
  }

  @override
  Future<void> addTrasaction(TransactionModel value) async {
    final db = await Hive.openBox<TransactionModel>('transaction_db');
    await db.add(value);
    refreshUI();
  }

  @override
  Future<void> deleteTransaction(int key) async {
    print("deleting" + key.toString());
    final db = await Hive.openBox<TransactionModel>('transaction_db');
    db.delete(key);
    refreshUI();
  }

  Future<void> refreshUI() async {
    List<TransactionModel> allTransactions = await getTransactions();

    print(allTransactions);

    transactions.value.clear();
    transactions.value=allTransactions;
    transactions.notifyListeners();

  }
}

// I copied the caetgory functions file and modified