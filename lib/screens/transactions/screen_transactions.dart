import 'package:brot_moneymanagementapp/db/functions/transactions/transaction_functions.dart';
import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:brot_moneymanagementapp/db/models/transactions/transaction_model.dart';
import 'package:brot_moneymanagementapp/screens/home/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDB().transactions,
        builder: (BuildContext ctx, List<TransactionModel> list, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(radius: 50, child: Text(list[index].date.toString())),
                    title: Text(list[index].purpose),
                    subtitle: Text(list[index].category==CategoryType.income?"Recieved":"Spent"+list[index].amount.toString()),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: list.length);
        });
  }
}
