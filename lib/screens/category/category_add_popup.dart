import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showAddCategoryPopup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Dialog title'),
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'hinttext'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: const [
                  RadioButton(
                    label: 'Income',
                    category: CategoryType.income,
                  ),
                  RadioButton(label: 'Expense', category: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Add'),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String label;
  final CategoryType category;

  const RadioButton({Key? key, required this.label, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder:
              (BuildContext ctx, CategoryType selectedCategory, Widget? _) {
            return Radio<CategoryType>(
                value: category,
                groupValue: selectedCategory,
                onChanged: (value) {
                  selectedCategoryNotifier.value = value!;
                  selectedCategoryNotifier.notifyListeners();
                });
          },
        ),
        Text(label)
      ],
    );
  }
}

// Radio button logic
//
// 1. A Radio button is displayed with the passed label and its value is set as the passed category
// 2. If the groupvalue matches with this categody, the buttom becoms selected
// 3. So we modify this group value to make the radio button selected and not selected
// 4. Radio<CategoryType> <-- because of this the value in onchanged functions gets the correct type.
// 5. Once i click on a radio button, its value is set in the notifier, as notifier notifies button is rebuild with that value in groupvalue.Value
// 6. So the for the other button, since now its value wont match with the groupvalue, it gets unselected

//Design concept - we should use such popup boxes anymore, should block the screen like this
