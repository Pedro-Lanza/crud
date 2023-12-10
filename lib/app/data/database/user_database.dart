import 'package:hive/hive.dart';

class UserDatabase {
  Box<Map<dynamic, dynamic>> getUserBox() => Hive.box('users');

  void addUser(Map<String, dynamic> user) {
    getUserBox().put(user['id'], user);
  }

  void updateUser(int id, Map<String, dynamic> user) {
    getUserBox().put(id, user);
  }

  void deleteUser(int id) {
    getUserBox().delete(id);
  }

  Map<dynamic, dynamic>? getUser(int id) {
    return getUserBox().get(id);
  }

  List<Map<dynamic, dynamic>> getUsers() {
    return getUserBox().values.toList();
  }
}
