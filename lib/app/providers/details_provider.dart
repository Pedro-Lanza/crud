import 'package:crud/app/database/details_database.dart';
import 'package:crud/app/models/details_entity.dart';
import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier {
  final DetailsDatabase db = DetailsDatabase();

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

  void deleteDetails(int index) {
    db.deleteDetails(index);
    notifyListeners();
  }
}
