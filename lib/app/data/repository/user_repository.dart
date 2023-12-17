import 'package:crud/app/data/adapters/user_adapter.dart';
import 'package:crud/app/data/database/user_database.dart';
import 'package:crud/app/data/models/user_entity.dart';

import 'package:dartz/dartz.dart';

class UserRepository {
  final UserDatabase db = UserDatabase();

  Either<Exception, User> fetchUser(int id) {
    try {
      var userMap = db.getUser(id);
      if (userMap == null) return Left(Exception('Usuário não encontrado'));
      User userEntity = UserAdapter.fromMap(userMap);
      return Right(userEntity);
    } catch (e) {
      return Left(Exception('Falha ao requisitar usuário'));
    }
  }

  Either<Exception, List<User>> fetchUsers() {
    try {
      var usersMap = db.getUsers();
      List<User> usersEntity = usersMap.map((e) => UserAdapter.fromMap(e)).toList();
      return Right(usersEntity);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Either<Exception, User> addUser(User user) {
    try {
      var userMap = UserAdapter.toMap(user);
      db.addUser(userMap);
      return Right(user);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Either<Exception, User> updateUser(int id, User user) {
    try {
      var userMap = UserAdapter.toMap(user);
      db.updateUser(id, userMap);
      return Right(user);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Either<Exception, bool> deleteUser(int id) {
    try {
      db.deleteUser(id);
      return Right(true);
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
