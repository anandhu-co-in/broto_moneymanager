import 'package:brot_moneymanagementapp/screens/category/screen_category.dart';
import 'package:brot_moneymanagementapp/screens/home/widgets/bottom_navigation.dart';
import 'package:brot_moneymanagementapp/screens/transactions/screen_transactions.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransactions(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if(selectedIndexNotifier.value==0) {
              print('Clicked plus at add transaction');
            }else{
              print('Clicked Plust at Addcategory');
            }

          }),
    );
  }
}
