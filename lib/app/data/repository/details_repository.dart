import 'package:crud/app/data/adapters/details_adapter.dart';
import 'package:crud/app/data/database/details_database.dart';
import 'package:crud/app/data/models/details_entity.dart';

class DetailsRepository {
  final DetailsDatabase db = DetailsDatabase();

  List<Details> fetchDetails() {
    var detailsMap = db.getDetails();
    List<Details> detailsEntity = detailsMap.map((e) => DetailsAdapter.fromMap(e)).toList();
    return detailsEntity;
  }

  Details fetchByUser(int id) {
    var detailsMap = db.getByUser(id);
    Details detailsEntity = DetailsAdapter.fromMap(detailsMap!);
    return detailsEntity;
  }

  void addDetails(Details details) {
    var detailsMap = DetailsAdapter.toMap(details);
    db.addDetails(detailsMap);
  }

  void updateDetails(int id, Details details) {
    var detailsMap = DetailsAdapter.toMap(details);
    db.updateDetails(id, detailsMap);
  }

  void deleteDetails(int id) {
    db.deleteDetails(id);
  }
}
