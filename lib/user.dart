import 'dart:convert';

class Student {
  final String name;
  final String number;
  final int marks;

  Student(this.name, this.number, this.marks);

  Student.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      number = json['number'],
      marks = json['marks'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'number': number,
    'marks': marks
  };
}

class ListClass {
  final List<String>? names;

  ListClass(this.names);

  ListClass.fromJson(Map<String, dynamic> json)
    : names = json['names'] != null ? List<String>.from(json['names']) : null;

  Map<String, dynamic> toJson() => {
    'names': names
  };
}

class ProgramFile {
  final List<bool> todayWork;
  final List<dynamic> completedDays;

  ProgramFile(this.todayWork, this.completedDays);

  ProgramFile.fromJson(Map<String, dynamic> json)
    : todayWork = json['todayWork'],
      completedDays = json['completedDays'];

  Map<String, dynamic> toJson() => {
    'todayWork': todayWork,
    'completedDays': completedDays
  };
}