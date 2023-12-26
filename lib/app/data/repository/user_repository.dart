import 'package:crud/app/data/adapters/user_adapter.dart';
import 'package:crud/app/data/database/user_database.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/exceptions/mapper_exception.dart';
import 'package:micro_core_result/micro_core_result.dart';

class UserRepository {
  final UserDatabase db = UserDatabase();

  Result<Exception, User> fetchUser(int id) {
    try {
      var userMap = db.getUser(id);
      if (userMap == null) return Left(Exception("Falha ao encontrar usuário"));
      User userEntity = UserAdapter.fromMap(userMap);
      return Right(userEntity);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, List<User>> fetchUsers() {
    try {
      var usersMap = db.getUsers();
      List<User> usersEntity = usersMap.map((e) => UserAdapter.fromMap(e)).toList();
      return Right(usersEntity);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, User> addUser(User user) {
    try {
      var userMap = UserAdapter.toMap(user);
      db.addUser(userMap);
      return Right(user);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, User> updateUser(int id, User user) {
    try {
      var userMap = UserAdapter.toMap(user);
      db.updateUser(id, userMap);
      return Right(user);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, int> deleteUser(int id) {
    try {
      db.deleteUser(id);
      return Right(id);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }
}
