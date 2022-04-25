import 'package:brot_moneymanagementapp/db/functions/cateogies/category_functions.dart';
import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:brot_moneymanagementapp/screens/add_transactions/screen_add_transaction.dart';
import 'package:brot_moneymanagementapp/screens/category/category_add_popup.dart';
import 'package:brot_moneymanagementapp/screens/category/screen_category.dart';
import 'package:brot_moneymanagementapp/screens/home/widgets/bottom_navigation.dart';
import 'package:brot_moneymanagementapp/screens/transactions/screen_transactions.dart';
import 'package:brot_moneymanagementapp/screens/webrequests/screen_api_response.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransactions(),
    ScreenCategory(),
    ScreenShowNumbnerInfo()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('MONEY MANAGER APPBAR'),
        centerTitle: true,
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, Widget? _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            if (selectedIndexNotifier.value == 0) {
              print('Clicked plus at add transaction');

              Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            } else if (selectedIndexNotifier.value == 1) {
              print('Clicked Plust at Addcategory');

              showAddCategoryPopup(context);

              // final newCategory=categoryModel(name: 'Anandhu', type: CategoryType.income);
              // CategoryDB().insertCategory(newCategory);

            }
          }),
    );
  }
}
