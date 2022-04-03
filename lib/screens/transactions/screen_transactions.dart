import 'package:brot_moneymanagementapp/screens/home/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return const Card(
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(radius: 50, child: Text('12\nDec')),
              title: Text('Title1000'),
              subtitle: Text('TravelSubtitle'),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
