import 'package:crud/app/data/database/details_database.dart';
import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier {
  final DetailsDatabase db = DetailsDatabase();
  final PostProvider posts = PostProvider();

  List<Details> get details => db.getDetails();

  Details? getByUser(int id) {
    return db.getByUser(id);
  }

  void addDetails(Details details) {
    db.addDetails(details);
    notifyListeners();
  }

  void updateDetails(int index, Details details) {
    db.updateDetails(index, details);
    notifyListeners();
  }

  void deleteDetails(int id) {
    posts.deleteByUser(id);
    db.deleteDetails(id);
    notifyListeners();
  }
}
