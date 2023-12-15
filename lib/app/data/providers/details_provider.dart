import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/data/repository/details_repository.dart';
import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider({required this.repository, required this.posts});
  final PostProvider posts; // = PostRepository();
  final DetailsRepository repository; // = DetailsRepository();

  List<Details> get details => repository.fetchDetails();

  Details? getByUser(int id) {
    return repository.fetchByUser(id);
  }

  void addDetails(Details details) {
    repository.addDetails(details);
    notifyListeners();
  }

  void updateDetails(int index, Details details) {
    repository.updateDetails(index, details);
    notifyListeners();
  }

  void deleteDetails(int id) {
    posts.deleteByUser(id);
    repository.deleteDetails(id);
    notifyListeners();
  }
}
