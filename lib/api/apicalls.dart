import 'dart:convert';

import 'package:brot_moneymanagementapp/api/apimodel.dart';
import 'package:http/http.dart' as http;

Future<NumberDateModel> getNumberFact({required int number}) async {
  final response =
      await http.get(Uri.parse('http://numbersapi.com/$number?json'));
  final _bodyAsJson = jsonDecode(response.body) as Map<String, dynamic>;
  final data = NumberDateModel.fromJson(_bodyAsJson);
  return data;
}
//Working
//User passes a numner
//response is getted
//converted into json object
//converted into an object of our model type. So we can easily access the data
