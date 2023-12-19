import 'package:crud/app/data/adapters/details_adapter.dart';
import 'package:crud/app/data/database/details_database.dart';
import 'package:crud/app/data/models/details_entity.dart';
import 'package:dartz/dartz.dart';

class DetailsRepository {
  final DetailsDatabase db = DetailsDatabase();

  Either<Exception, List<Details>> fetchDetails() {
    try {
      var detailsMap = db.getDetails();
      List<Details> detailsEntity = detailsMap.map((e) => DetailsAdapter.fromMap(e)).toList();
      return Right(detailsEntity);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, Details> fetchByUser(int id) {
    try {
      var detailsMap = db.getByUser(id);
      Details detailsEntity = DetailsAdapter.fromMap(detailsMap!);
      throw Exception();
      return Right(detailsEntity);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, Details> addDetails(Details details) {
    try {
      var detailsMap = DetailsAdapter.toMap(details);
      db.addDetails(detailsMap);
      return Right(details);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, Details> updateDetails(int id, Details details) {
    try {
      var detailsMap = DetailsAdapter.toMap(details);
      db.updateDetails(id, detailsMap);
      return Right(details);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }

  Either<Exception, int> deleteDetails(int id) {
    try {
      db.deleteDetails(id);
      return Right(id);
    } catch (e) {
      return Left(Exception("Falha na requisição"));
    }
  }
}
