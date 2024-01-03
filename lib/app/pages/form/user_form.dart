import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/form/bloc/form_bloc.dart';
import 'package:crud/app/pages/form/bloc/form_event.dart';
import 'package:crud/app/pages/form/bloc/form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as User?;

    context.read<FormBloc>().add(LoadForm(user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormStates>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.render(),
          ),
        );
      },
    );
  }
}

class FormEvents {}
