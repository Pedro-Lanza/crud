import 'package:crud/app/models/details_entity.dart';
import 'package:hive/hive.dart';

class DetailsDatabase {
  Box<Details> getDetailsBox() => Hive.box('details');

  void addDetails(Details details) {
    getDetailsBox().put(details.id, details);
  }

  void updateDetails(int id, Details details) {
    getDetailsBox().put(id, details);
  }

  void deleteDetails(int index) {
    getDetailsBox().deleteAt(index);
  }

  List<Details> getDetails() => getDetailsBox().values.toList();

  Details? getByUser(int id) => getDetailsBox().get(id);
}
