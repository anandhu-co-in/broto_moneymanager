import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';

ValueNotifier<List<categoryModel>> studentListNotifier = ValueNotifier([]);


abstract class CategoryDBFunctions{
  Future<List<categoryModel>> getCategories();
  Future<void> insertCategory(categoryModel value);
}

class CategoryDB implements CategoryDBFunctions{

  @override
  Future<List<categoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<categoryModel>('category_db');

    print(categoryDB.values.toList());
    return categoryDB.values.toList();

  }

  @override
  Future<void> insertCategory(categoryModel value) async {
    final categoryDB = await Hive.openBox<categoryModel>('category_db');
    await categoryDB.add(value);

    getCategories();
  }

}


// //get all studentss
// Future<void> getAllStudents() async{
//
//   final studentBD= await Hive.openBox<categoryModel>('student_db');
//   studentListNotifier.value.clear();
//   studentListNotifier.value.addAll(studentBD.values);
//   studentListNotifier.notifyListeners();
// }
//
// //Add new student to hive db
// Future<void> addStudent(categoryModel value) async{
//
//   //save the new student to db
//   final studentBD= await Hive.openBox<categoryModel>('student_db');
//   await studentBD.add(value);
//   getAllStudents();
// }




// //get all students
// Future<void> deleteStudent(int key) async{
//   final studentBD= await Hive.openBox<categoryModel>('student_db');
//   await studentBD.delete(key);
//   getAllStudents();
// }
//


//WHen we use hive
//i adde annoation above the fields in the model calss
// i registered the have thins on the main fucniton
// i extendded a hivemodel class in them model clas, that gave an id field, which i am using to pass into delete
