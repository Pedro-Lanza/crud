import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/data/repository/details_repository.dart';
import 'package:micro_core_result/micro_core_result.dart';

class DetailsProvider {
  DetailsProvider({required this.repository, required this.posts});
  final PostProvider posts; // = PostRepository();
  final DetailsRepository repository; // = DetailsRepository();

  Result<Exception, List<Details>> get details {
    var request = repository.fetchDetails();
    Result<Exception, List<Details>> response = request((l) => Left(l), (r) => Right(r));
    return response;
  }

  Result<Exception, Details> getByUser(int id) {
    var request = repository.fetchByUser(id);
    Result<Exception, Details> response = request((l) => Left(l), (r) => Right(r));
    // notifyListeners();
    return response;
  }

  Result<Exception, Details> addDetails(Details details) {
    var request = repository.addDetails(details);
    Result<Exception, Details> response = request((l) => Left(l), (r) => Right(r));
    return response;
  }

  Result<Exception, Details> updateDetails(int index, Details details) {
    var request = repository.updateDetails(index, details);
    Result<Exception, Details> response = request((l) => Left(l), (r) => Right(r));
    return response;
  }

  Result<Exception, int> deleteDetails(int id) {
    posts.deleteByUser(id);
    var request = repository.deleteDetails(id);
    Result<Exception, int> response = request((l) => Left(l), (r) => Right(r));
    return response;
  }
}
