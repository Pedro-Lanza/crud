import 'package:crud/app/data/database/user_database.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final UserDatabase db = UserDatabase();
  final DetailsProvider details = DetailsProvider();
  int maxId = 0;

  List<User> get users => db.getUsers();

  int get maxid => maxId++;

  User? getById(int id) {
    if (id < 0) return null;
    // return db.getUserBox().get(id);
    List<User> list = users.where((e) => e.id == id).toList();
    return list.isEmpty ? null : list[0];
  }

  int get count => db.getUsers().length;

  void addUser(User user) {
    if (user.id != null) {
      if (getById(user.id!) != null) {
        updateUser(user.id!, user);
        return;
      }
    }

    user = User(
      id: user.id,
      name: user.name,
      surName: user.surName,
      image: user.image,
      details: user.details,
    );
    db.addUser(user);
    notifyListeners();
  }

  void updateUser(int id, User user) {
    User? u = getById(id);
    if (u != null) {
      db.updateUser(id, user);
      notifyListeners();
    }
  }

  void deleteUser(int index) {
    User? user = getById(index);
    if (user != null) {
      db.deleteUser(user.id!);
      details.deleteDetails(user.details);
      notifyListeners();
    }
  }
}
