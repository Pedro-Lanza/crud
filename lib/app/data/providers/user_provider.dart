import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserProvider({required this.repository, required this.details});
  final DetailsProvider details; // = DetailsProvider();
  final UserRepository repository; // = UserRepository();

  List<User> get users {
    var request = repository.fetchUsers();
    return request.fold((l) => [], (r) => r);
  }

  int get count {
    var request = repository.fetchUsers();
    return request.fold((l) => 0, (r) => r.length);
  }

  int get maxid {
    var request = repository.fetchUsers();
    return request.fold((l) => 0, (r) => r.fold<int>(0, (max, e) => e.id! > max ? e.id! : max) + 1);
  }

  User? getById(int id) {
    var request = repository.fetchUser(id);
    return request.fold((l) => null, (r) => r);
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
