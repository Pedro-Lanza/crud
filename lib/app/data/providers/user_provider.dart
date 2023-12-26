import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:micro_core_result/micro_core_result.dart';

class UserProvider with ChangeNotifier {
  UserProvider({required this.repository, required this.details});
  final DetailsProvider details; // = DetailsProvider();
  final UserRepository repository; // = UserRepository();

  Result<Exception, List<User>> get users {
    var request = repository.fetchUsers();
    return request((l) => Left(l), (r) => Right(r));
  }

  Result<Exception, int> get count {
    var request = repository.fetchUsers();
    return request((l) => Left(l), (r) => Right(r.length));
  }

  Result<Exception, int> get maxid {
    var request = repository.fetchUsers();
    return request((l) => Left(l), (r) => Right(r.fold<int>(0, (max, e) => e.id! > max ? e.id! : max) + 1));
  }

  Result<Exception, User> getById(int id) {
    var request = repository.fetchUser(id);
    return request((l) => Left(l), (r) => Right(r));
  }

  Result<Exception, User> addUser(User user) {
    // if (user.id != null) {
    //   if (getById(user.id!) != null) {
    //     updateUser(user.id!, user);
    //     return;
    //   }
    // }
    var checkUser = updateUser(user.id!, user);
    var exists = checkUser((l) => false, (r) => true);
    if (exists) return Right(user);

    user = User(
      id: user.id,
      name: user.name,
      surName: user.surName,
      image: user.image,
      details: user.details,
    );
    var request = repository.addUser(user);
    Result<Exception, User> response = request((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Result<Exception, User> updateUser(int id, User user) {
    var check = getById(id);
    var exists = check((l) => l, (r) => true);
    if (exists != true) return Left(exists as Exception);

    var request = repository.updateUser(id, user);
    Result<Exception, User> response = request((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
    // if (u != null) {
    //   repository.updateUser(id, user);
    //   notifyListeners();
    // }
  }

  Result<Exception, int> deleteUser(int id) {
    var deleteDetails = details.deleteDetails(id);
    var deleted = deleteDetails((l) => l, (r) => true);
    if (deleted != true) return Left(deleted as Exception);

    var request = repository.deleteUser(id);
    Result<Exception, int> response = request((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
    // if (user != null) {
    //   repository.deleteUser(user.id!);
    //   details.deleteDetails(user.details);
    //   notifyListeners();
    // }
  }
}
