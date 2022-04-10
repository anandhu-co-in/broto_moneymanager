import 'package:brot_moneymanagementapp/db/functions/cateogies/category_functions.dart';
import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategories,
        builder: (BuildContext ctx, List<categoryModel> list, Widget? _){
          return ListView.separated(
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    title: Text(list[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        CategoryDB().deleteCategory(list[index].key);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 2,
                );
              },
              itemCount: list.length);
        }
    );
  }
}
