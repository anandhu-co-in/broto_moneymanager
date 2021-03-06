class NumberDateModel {
  String? text;
  int? number;
  bool? found;
  String? type;

  NumberDateModel({this.text, this.number, this.found, this.type});

  NumberDateModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    number = json['number'];
    found = json['found'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['number'] = this.number;
    data['found'] = this.found;
    data['type'] = this.type;
    return data;
  }
}

//This was generated by giving the json sample at https://javiercbk.github.io/json_to_dart/
//and then used in apicalls.dart
//In the tutorial they had added 2 packages , but i didn't use it
// json_annotation: ^4.4.0
//  json_serializable: ^6.1.6
