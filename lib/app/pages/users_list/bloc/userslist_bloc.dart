import 'package:crud/app/data/providers/user_provider.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_event.dart';
import 'package:crud/app/pages/users_list/bloc/userslist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc({required this.provider}) : super(LoadingList()) {
    on<FetchUsers>(_onFetchUsers);
    on<DeleteUser>(_onDeleteUser);
  }

  final UserProvider provider;

  Future<void> _onFetchUsers(FetchUsers event, Emitter<ListState> emit) async {
    emit(LoadingList());
    final request = provider.users;
    request(
      (l) => emit(ErrorList(l)),
      (r) => emit(LoadedList(r)),
    );
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<ListState> emit) async {
    final request = provider.deleteUser(event.id);
    request(
      (l) async => await _showErrorDialog(event.context, l.toString()),
      (r) => add(FetchUsers()), //emit(SuccessList()),
    );
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
