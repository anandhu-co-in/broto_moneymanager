import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';

ValueNotifier<List<categoryModel>> studentListNotifier = ValueNotifier([]);

abstract class CategoryDBFunctions {
  Future<List<categoryModel>> getCategories();
  Future<void> addCategory(categoryModel value);
  Future<void> deleteCategory(int key);
}

class CategoryDB implements CategoryDBFunctions {
  // Below chunk of code makes this class singletone, (same object is returned when calling CategryDB())
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<categoryModel>> incomeCategories = ValueNotifier([]);
  ValueNotifier<List<categoryModel>> expenseCategories = ValueNotifier([]);

  @override
  Future<List<categoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<categoryModel>('category_db');
    print('RETREIVED ALL CATEGOEIES FROM DB');
    return categoryDB.values.toList();
  }

  @override
  Future<void> addCategory(categoryModel value) async {
    final categoryDB = await Hive.openBox<categoryModel>('category_db');
    await categoryDB.add(value);
    refreshUI();
  }

  @override
  Future<void> deleteCategory(int key) async {
    print("deleting" + key.toString());
    final categoryDB = await Hive.openBox<categoryModel>('category_db');
    categoryDB.delete(key);
    refreshUI();
  }

  Future<void> refreshUI() async {
    List<categoryModel> allCategories = await getCategories();

    incomeCategories.value.clear();
    expenseCategories.value.clear();

    Future.forEach(allCategories, (categoryModel item) {
      if (item.type == CategoryType.income) {
        incomeCategories.value.add(item);
      } else {
        expenseCategories.value.add(item);
      }
    });
    incomeCategories.notifyListeners();
    expenseCategories.notifyListeners();
  }
}

//WHen we use hive
//i adde annoation above the fields in the model calss
// i registered the have thins on the main fucniton
// i extendded a hivemodel class in them model clas, that gave an id field, which i am using to pass into delete
