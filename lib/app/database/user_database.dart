import 'package:crud/app/models/user_entity.dart';
import 'package:hive/hive.dart';

class UserDatabase {
  Box<User> getUserBox() => Hive.box('users');

  void addUser(User user) {
    print('here:${user.id}');
    getUserBox().put(user.id!, user);
  }

  void updateUser(int id, User user) {
    getUserBox().put(id, user);
  }

  void deleteUser(int index) {
    getUserBox().delete(index);
  }

  List<User> getUsers() => getUserBox().values.toList();
}
