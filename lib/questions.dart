import 'dart:math';

import 'package:tuple/tuple.dart';

import 'department.dart';

class Questions {
  static Department getRandomDepartment(List<Department> departments) {
    Random random = new Random.secure();
    return departments[random.nextInt(departments.length)];
  }

  static Tuple2<String, int> getRandomQuestion(Department department) {
    Random random = new Random.secure();
    int type = random.nextInt(3);
    String ret;
    switch (type) {
      case 0:
        ret = "Numéro : " + department.departmentNum;
        break;
      case 1:
        ret = "Nom : " + department.departmentName;
        break;
      case 2:
        ret = "Préfecture : " + department.prefecture;
        break;
      default:
    }

    return new Tuple2<String, int>(ret, type);
  }
}
