import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/form/bloc/form_event.dart';
import 'package:crud/app/pages/form/bloc/form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_core_result/micro_core_result.dart';

class FormBloc extends Bloc<FormEvent, FormStates> {
  UserProvider userProvider;
  DetailsProvider detailsProvider;

  FormBloc({required this.userProvider, required this.detailsProvider}) : super(LoadingForm()) {
    on<AddUser>(_onAddUser);
    on<LoadForm>(_onLoadForm);
  }

  Future<void> _onAddUser(AddUser event, Emitter<FormStates> emit) async {
    var requestDetails = detailsProvider.addDetails(event.details);
    requestDetails(
      (l) {
        emit(DialogForm(l));
        return;
      },
      (r) => null,
    );

    var requestUser = userProvider.addUser(event.user);
    requestUser(
      (l) => emit(DialogForm(l)),
      (r) => emit(SuccessfulForm()),
    );
  }

  Future<void> _onLoadForm(LoadForm event, Emitter<FormStates> emit) async {
    emit(LoadingForm());
    Result<Exception, Map<String, dynamic>> form = _loadFormData(event.user);
    form(
      (l) => emit(ErrorForm(l)),
      (r) {
        emit(LoadedForm(r));
      },
    );
  }

  Result<Exception, Map<String, dynamic>> _loadFormData(User? user) {
    Map<String, dynamic> formData = {};
    Exception? error;

    if (user == null) {
      var request = userProvider.maxid;
      var maxid = request((l) {
        error = l;
      }, (r) => r);
      if (error != null) return Left(error!);

      formData['id'] = maxid;
      formData['image'] = null;
      formData['private'] = false;
      formData['gender'] = 'nada a declarar';
      return Right(formData);
    }

    Details detail;
    var request = detailsProvider.getByUser(user.id!);
    var response = request((l) {
      error = l;
    }, (r) => r);
    if (error != null) return Left(error!);

    detail = response as Details;
    formData['id'] = user.id;
    formData['image'] = user.image;
    formData['name'] = user.name;
    formData['surname'] = user.surName;
    formData['description'] = detail.description;
    formData['birth'] = detail.birth;
    formData['private'] = detail.private;
    formData['gender'] = detail.gender;
    formData['cpf'] = detail.cpf;
    formData['telefone'] = detail.telefone;

    return Right(formData);
  }
}
