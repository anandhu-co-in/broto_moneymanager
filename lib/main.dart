import 'package:brot_moneymanagementapp/db/models/categories/category_model.dart';
import 'package:brot_moneymanagementapp/screens/add_transactions/screen_add_transaction.dart';
import 'package:brot_moneymanagementapp/screens/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(categoryModelAdapter().typeId)) {
    Hive.registerAdapter(categoryModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manger App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ScreenHome(),
      routes: {ScreenAddTransaction.routeName: (ctx) => ScreenAddTransaction()},
    );
  }
}
