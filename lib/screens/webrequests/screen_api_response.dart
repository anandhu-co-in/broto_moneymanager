import 'package:brot_moneymanagementapp/api/apicalls.dart';
import 'package:flutter/material.dart';

class ScreenShowNumbnerInfo extends StatefulWidget {
  const ScreenShowNumbnerInfo({Key? key}) : super(key: key);

  @override
  State<ScreenShowNumbnerInfo> createState() => _ScreenShowNumbnerInfoState();
}

class _ScreenShowNumbnerInfoState extends State<ScreenShowNumbnerInfo> {
  final _numberController = TextEditingController();
  String _resultText = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _numberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter Numner'),
          ),
          ElevatedButton(
              onPressed: () async {
                if (_numberController.text.trim().isNotEmpty) {
                  final result = await getNumberFact(
                      number: int.parse(_numberController.text.trim()));
                  setState(() {
                    _resultText = result.text!;
                  });
                } else {
                  print('Enter a number');
                  setState(() {
                    _numberController.text = "";
                  });
                }
              },
              child: Text('Get Result')),
          Text(_resultText)
        ],
      ),
    );
  }
}
