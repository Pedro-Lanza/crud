import 'package:crud/app/data/adapters/details_adapter.dart';
import 'package:crud/app/data/database/details_database.dart';
import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/exceptions/mapper_exception.dart';
import 'package:micro_core_result/micro_core_result.dart';

class DetailsRepository {
  final DetailsDatabase db = DetailsDatabase();

  Result<Exception, List<Details>> fetchDetails() {
    try {
      var detailsMap = db.getDetails();
      List<Details> detailsEntity = detailsMap.map((e) => DetailsAdapter.fromMap(e)).toList();
      return Right(detailsEntity);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, Details> fetchByUser(int id) {
    try {
      var detailsMap = db.getByUser(id);
      Details detailsEntity = DetailsAdapter.fromMap(detailsMap!);
      return Right(detailsEntity);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, Details> addDetails(Details details) {
    try {
      var detailsMap = DetailsAdapter.toMap(details);
      db.addDetails(detailsMap);
      return Right(details);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, Details> updateDetails(int id, Details details) {
    try {
      var detailsMap = DetailsAdapter.toMap(details);
      db.updateDetails(id, detailsMap);
      return Right(details);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Result<Exception, int> deleteDetails(int id) {
    try {
      db.deleteDetails(id);
      return Right(id);
    } on MapperException catch (mapperException) {
      return Left(mapperException);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }
}
