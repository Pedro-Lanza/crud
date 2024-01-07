import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/form/bloc/form_bloc.dart';
import 'package:crud/app/pages/form/bloc/form_event.dart';
import 'package:crud/app/pages/form/bloc/form_state.dart';
import 'package:crud/app/pages/form/widgets/error_widget.dart';
import 'package:crud/app/pages/form/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key, required this.bloc});
  final FormBloc bloc;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User?;

    widget.bloc.add(LoadForm(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocListener<FormBloc, FormStates>(
        listener: (context, state) {
          if (state is DialogForm) {
            _showErrorDialog(context, state.error.toString());
          }
          if (state is SuccessfulForm) {
            Navigator.of(context).pop();
          }
        },
        bloc: widget.bloc,
        child: BlocBuilder<FormBloc, FormStates>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: switch (state) {
                LoadingForm() || DialogForm() || SuccessfulForm() => const CircularProgressIndicator(),
                LoadedForm() => FormWidget(formData: state.formData),
                ErrorForm() => FormErrorWidget(error: state.error),
              },
            );
          },
        ),
      ),
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
