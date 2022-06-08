import 'dart:convert';

class Employee {
  List<Employee> listEmployeeFromJson(String str) =>
      List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

  Employee({
    this.id,
    this.code,
    this.name,
    this.birthDay,
    this.gender,
    this.birthPlace,
    this.age,
    this.address,
  });

  Employee.fromJson(dynamic json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
    birthDay = json['BirthDay'];
    gender = json['Gender'];
    birthPlace = json['BirthPlace'];
    age = json['Age'];
    address = json['Address'];
  }
  int? id;
  String? code;
  String? name;
  String? birthDay;
  String? gender;
  String? birthPlace;
  int? age;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Code'] = code;
    map['Name'] = name;
    map['BirthDay'] = birthDay;
    map['Gender'] = gender;
    map['BirthPlace'] = birthPlace;
    map['Age'] = age;
    map['Address'] = address;
    return map;
  }
}
