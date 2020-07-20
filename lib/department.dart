import 'dart:convert';

class Department {
  final String departmentName;
  final String departmentNum;
  final String prefecture;
  final String region;

  Department(this.departmentName, this.departmentNum, this.prefecture, this.region);

  Department.fromJson(Map<String, dynamic> json)
      : departmentName = json['dep_name'],
        departmentNum = json['num_dep'],
        prefecture = json['prefecture'],
        region = json['region_name'];

  Map<String, dynamic> toJson() =>
    {
      'dep_name': departmentName,
      'num_dep': departmentNum,
      'prefecture': prefecture,
      'region_name': region,
    };

  static List<Department> parseJson(String response) {
    if(response==null){
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Department>((json) => new Department.fromJson(json)).toList();
  }
}