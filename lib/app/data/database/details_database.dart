import 'package:hive/hive.dart';

class DetailsDatabase {
  Box<Map<dynamic, dynamic>> getDetailsBox() => Hive.box('details');

  void addDetails(Map<String, dynamic> details) {
    getDetailsBox().put(details['id'], details);
  }

  void updateDetails(int id, Map<String, dynamic> details) {
    getDetailsBox().put(id, details);
  }

  void deleteDetails(int index) {
    getDetailsBox().delete(index);
  }

  List<Map<dynamic, dynamic>> getDetails() => getDetailsBox().values.toList();

  Map<dynamic, dynamic>? getByUser(int id) => getDetails().where((e) => e['user'] == id).toList()[0];
}
