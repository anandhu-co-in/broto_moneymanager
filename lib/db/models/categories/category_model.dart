import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category_model.g.dart'; //when that generator command is runnnig, as i add this .g.dart filean and saved, the studentmode.g.dart is generated succesfully


@HiveType(typeId: 2)
enum CategoryType{
  @HiveField(0)
  income,
  @HiveField(1)
  expense
}


@HiveType(typeId: 1)
class categoryModel extends HiveObject{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isDeleted; //For soft deleting category

  @HiveField(2)
  final CategoryType type;

  categoryModel({required this.name, required this.type, this.isDeleted=false});

  @override
  String toString(){
    return '{$name $type}';
  }

}


//Code to build hte adatpeter file
// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs