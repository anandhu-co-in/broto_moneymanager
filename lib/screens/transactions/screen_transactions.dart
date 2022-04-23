import 'package:brot_moneymanagementapp/db/functions/cateogies/category_functions.dart';
import 'package:brot_moneymanagementapp/db/functions/transactions/transaction_functions.dart';
import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:brot_moneymanagementapp/db/models/transactions/transaction_model.dart';
import 'package:brot_moneymanagementapp/screens/home/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB().refreshUI();
    CategoryDB().refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB().transactions,
        builder: (BuildContext ctx, List<TransactionModel> list, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                return Slidable(
                  key: Key(list[index].key.toString()),
                  startActionPane:
                      ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                        icon: Icons.delete,
                        onPressed: (ctx) async {
                          await TransactionDB()
                              .deleteTransaction(list[index].key);
                        }),
                  ]),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: list[index].type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        child: Text(
                          formatDate(list[index].date),
                        ),
                      ),
                      title: Text(list[index].purpose),
                      subtitle: Text(list[index].type == CategoryType.income
                          ? "Recieved"
                          : "Spent" + list[index].amount.toString()),
                    ),
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

  String formatDate(DateTime date) {
    var format = DateFormat.MMMd();
    var dateString = format.format(date);
    final splitDate = dateString.split(' ');
    return '${splitDate.first}\n${splitDate.last}';
  }
}
