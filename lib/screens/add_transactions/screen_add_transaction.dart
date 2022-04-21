import 'package:flutter/material.dart';

class ScreenAddTransaction extends StatelessWidget {
  const ScreenAddTransaction({Key? key}) : super(key: key);

  //will us this name to route from main page
  static const routeName = "add-transaction";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text('Add Transaction Screen - IMPLEMENTE THIS'),
      ),
    );
  }
}
