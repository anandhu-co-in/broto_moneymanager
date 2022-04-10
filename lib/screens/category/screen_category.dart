import 'package:brot_moneymanagementapp/db/functions/cateogies/category_functions.dart';
import 'package:brot_moneymanagementapp/screens/category/expense_list.dart';
import 'package:brot_moneymanagementapp/screens/category/income_list.dart';
import 'package:flutter/material.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    // To check if db functions work
    CategoryDB().getCategories().then((value) => print(value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            indicatorColor: Colors.green,
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              ),
            ]),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          //Expanded is required else will get error
          child: TabBarView(
              controller: _tabController,
              children: [IncomeList(), ExpenseList()]),
        )
      ],
    );
  }
}
