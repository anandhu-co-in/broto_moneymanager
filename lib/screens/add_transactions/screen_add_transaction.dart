import 'package:brot_moneymanagementapp/db/functions/cateogies/category_functions.dart';
import 'package:brot_moneymanagementapp/db/functions/transactions/transaction_functions.dart';
import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:brot_moneymanagementapp/db/models/transactions/transaction_model.dart';
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
  dynamic _selectedCategoryKey;

  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    CategoryDB()
        .refreshUI(); // this maynot be how it should be done, this is my temp way
    _selectedCategoryType = CategoryType.income;
    // TODO: implement initState
    super.initState();
  }

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
                controller: _purposeController,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                ),
              ),
              TextFormField(
                controller: _amountController,
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
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.income;
                                _selectedCategoryKey =
                                    null; //if i dont clear the current selected id, it will cause error, since it will look the same id in the expense list while we are switching from income ot exepense
                              });
                            }),
                        const Text('Income')
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.expense,
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.expense;
                                _selectedCategoryKey = null;
                              });
                            }),
                        const Text('Expense')
                      ],
                    )
                  ]),
              DropdownButton<dynamic>(
                //dybanid is the type of value
                hint: const Text(
                    'Select item'), //When value is null, this hint will be shown, else the dropwown menu item with that value
                value: _selectedCategoryKey,
                items: (_selectedCategoryType == CategoryType.expense
                        ? CategoryDB().expenseCategories
                        : CategoryDB().incomeCategories)
                    .value
                    .map((item) => DropdownMenuItem(
                        onTap: () {
                          _selectedCategoryModel = item;
                        },
                        value: item.key,
                        child: Text(item.name)))
                    .toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _selectedCategoryKey = selectedValue;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () async {

                    if(_purposeController.text.trim().isEmpty){
                      print("Enter purpose");
                      return;
                    }

                    if(_amountController.text.trim().isEmpty){
                      print("Enter amount");
                      return;
                    }

                    if(_selectedDate==null){
                      print("select date");
                      return;
                    }

                    if(_selectedCategoryKey==null){
                      print("select category");
                      return;
                    }

                    if(double.tryParse(_amountController.text)==null){
                      print("couldnt parse amount");
                      return;
                    }

                    TransactionModel transaction = TransactionModel(
                        purpose: _purposeController.text,
                        amount: double.parse(_amountController.text),
                        date: _selectedDate!,
                        category: _selectedCategoryModel!,
                        type: _selectedCategoryType!);

                    await TransactionDB.instance.addTrasaction(transaction);
                    Navigator.of(context).pop();
  
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
