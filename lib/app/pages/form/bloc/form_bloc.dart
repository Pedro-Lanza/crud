import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/form/bloc/form_event.dart';
import 'package:crud/app/pages/form/bloc/form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
      (l) async => await _showErrorDialog(event.context, l.toString()),
      (r) => null,
    );

    var requestUser = userProvider.addUser(event.user);
    requestUser(
      (l) async => await _showErrorDialog(event.context, l.toString()),
      (r) => Navigator.of(event.context).pop(),
    );
  }

  Future<void> _onLoadForm(LoadForm event, Emitter<FormStates> emit) async {
    emit(LoadingForm());
    Result<Exception, Map<String, dynamic>> form = _loadFormData(event.user);
    form(
      (l) => emit(ErrorForm(l)),
      (r) {
        var txt = TextEditingController(text: r['birth'] != null ? DateFormat("dd/MM/yyyy").format(r['birth']) : null);
        emit(LoadedForm(r, txt));
      },
    );
    // if (form == null) emit(ErrorList(error))
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

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tentar Novamente'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
