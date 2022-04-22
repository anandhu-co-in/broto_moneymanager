import 'package:brot_moneymanagementapp/db/functions/cateogies/category_functions.dart';
import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:flutter/material.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({Key? key}) : super(key: key);

  //will us this name to route from main page
  static const routeName = "add-transaction";

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  categoryModel? _selectedCategoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
              TextButton.icon(
                  //inditialy whe page loads _selectedDate is null, so button has label select date
                  //when user clicks slect date, is uses date picker to get date value from user
                  //note that the here we user awync await
                  //if user has provided a date it is set to the state selecteddate, since state changes the button label changes as we used ?:
                  //thats how this works
                  //we used stateful compoenent in this example. setstate is used to change the state and update the ui

                  onPressed: () async {
                    final _selecteDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now().add(const Duration(days: 4)),
                    );

                    //if user didn't select date and cancels the popup,it will return null,
                    if (_selecteDateTemp != null) {
                      print('Date selected');
                      print(_selecteDateTemp);
                      setState(() {
                        _selectedDate = _selecteDateTemp;
                      });
                    } else {
                      print('No date selected');
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null
                      ? 'Select DATE'
                      : _selectedDate.toString())),
              Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, //to make the two childs center
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.income,
                            groupValue: CategoryType.income,
                            onChanged: (newValue) {}),
                        const Text('Income')
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.expense,
                            groupValue: CategoryType.income,
                            onChanged: (newValue) {}),
                        const Text('Expense')
                      ],
                    )
                  ]),
              DropdownButton(
                hint: const Text('Select item'),
                items: CategoryDB()
                    .expenseCategories
                    .value
                    .map((item) => DropdownMenuItem(
                        value: item.key, child: Text(item.name)))
                    .toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                },
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
