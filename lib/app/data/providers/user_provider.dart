import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserProvider({required this.repository, required this.details});
  final DetailsProvider details; // = DetailsProvider();
  final UserRepository repository; // = UserRepository();

  Either<Exception, List<User>> get users {
    var request = repository.fetchUsers();
    return request.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Exception, int> get count {
    var request = repository.fetchUsers();
    return request.fold((l) => Left(l), (r) => Right(r.length));
  }

  Either<Exception, int> get maxid {
    var request = repository.fetchUsers();
    return request.fold((l) => Left(l), (r) => Right(r.fold<int>(0, (max, e) => e.id! > max ? e.id! : max) + 1));
  }

  Either<Exception, User> getById(int id) {
    var request = repository.fetchUser(id);
    return request.fold((l) => Left(l), (r) => Right(r));
  }

  Either<Exception, User> addUser(User user) {
    // if (user.id != null) {
    //   if (getById(user.id!) != null) {
    //     updateUser(user.id!, user);
    //     return;
    //   }
    // }
    var checkUser = updateUser(user.id!, user);
    var exists = checkUser.fold((l) => false, (r) => true);
    if (exists) return Right(user);

    user = User(
      id: user.id,
      name: user.name,
      surName: user.surName,
      image: user.image,
      details: user.details,
    );
    var request = repository.addUser(user);
    Either<Exception, User> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, User> updateUser(int id, User user) {
    var check = getById(id);
    var exists = check.fold((l) => l, (r) => true);
    if (exists != true) return Left(exists as Exception);

    var request = repository.updateUser(id, user);
    Either<Exception, User> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
    // if (u != null) {
    //   repository.updateUser(id, user);
    //   notifyListeners();
    // }
  }

  Either<Exception, int> deleteUser(int id) {
    var deleteDetails = details.deleteDetails(id);
    var deleted = deleteDetails.fold((l) => l, (r) => true);
    if (deleted != true) return Left(deleted as Exception);

    var request = repository.deleteUser(id);
    Either<Exception, int> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
    // if (user != null) {
    //   repository.deleteUser(user.id!);
    //   details.deleteDetails(user.details);
    //   notifyListeners();
    // }
  }
}
