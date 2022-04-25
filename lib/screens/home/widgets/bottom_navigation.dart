import 'package:brot_moneymanagementapp/screens/home/screen_home.dart';
import 'package:flutter/material.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
              onTap: (tappedIndex) {
                ScreenHome.selectedIndexNotifier.value = tappedIndex;
              },
              currentIndex: updatedIndex,
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Transactions'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.web), label: 'Web Request')
              ]);
        });
  }
}
