import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/data/repository/details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider({required this.repository, required this.posts});
  final PostProvider posts; // = PostRepository();
  final DetailsRepository repository; // = DetailsRepository();

  Either<Exception, List<Details>> get details {
    var request = repository.fetchDetails();
    Either<Exception, List<Details>> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, Details> getByUser(int id) {
    var request = repository.fetchByUser(id);
    Either<Exception, Details> response = request.fold((l) => Left(l), (r) => Right(r));
    // notifyListeners();
    return response;
  }

  Either<Exception, Details> addDetails(Details details) {
    var request = repository.addDetails(details);
    Either<Exception, Details> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, Details> updateDetails(int index, Details details) {
    var request = repository.updateDetails(index, details);
    Either<Exception, Details> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }

  Either<Exception, int> deleteDetails(int id) {
    posts.deleteByUser(id);
    var request = repository.deleteDetails(id);
    Either<Exception, int> response = request.fold((l) => Left(l), (r) => Right(r));
    notifyListeners();
    return response;
  }
}
