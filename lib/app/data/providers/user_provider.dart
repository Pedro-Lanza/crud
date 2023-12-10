import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final UserRepository repository = UserRepository();
  final DetailsProvider details = DetailsProvider();

  List<User> get users => repository.fetchUsers();

  int get count => repository.fetchUsers().length;

  int get maxid => repository.fetchUsers().fold<int>(0, (max, e) => e.id! > max ? e.id! : max) + 1;

  User? getById(int id) {
    if (id < 0) return null;
    return repository.fetchUser(id);
  }

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
    repository.addUser(user);
    notifyListeners();
  }

  void updateUser(int id, User user) {
    User? u = getById(id);
    if (u != null) {
      repository.updateUser(id, user);
      notifyListeners();
    }
  }

  void deleteUser(int index) {
    User? user = getById(index);
    if (user != null) {
      repository.deleteUser(user.id!);
      details.deleteDetails(user.details);
      notifyListeners();
    }
  }
}
