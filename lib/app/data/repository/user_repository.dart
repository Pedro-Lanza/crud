import 'package:crud/app/data/adapters/user_adapter.dart';
import 'package:crud/app/data/database/user_database.dart';
import 'package:crud/app/data/models/user_entity.dart';

class UserRepository {
  final UserDatabase db = UserDatabase();

  User? fetchUser(int id) {
    var userMap = db.getUser(id);
    if (userMap == null) return null;
    User userEntity = UserAdapter.fromMap(userMap);
    return userEntity;
  }

  List<User> fetchUsers() {
    var usersMap = db.getUsers();
    List<User> usersEntity = usersMap.map((e) => UserAdapter.fromMap(e)).toList();
    return usersEntity;
  }

  void addUser(User user) {
    var userMap = UserAdapter.toMap(user);
    db.addUser(userMap);
  }

  void updateUser(int id, User user) {
    var userMap = UserAdapter.toMap(user);
    db.updateUser(id, userMap);
  }

  void deleteUser(int id) {
    db.deleteUser(id);
  }
}
