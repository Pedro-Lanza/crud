import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/pages/users_list/widgets/error_widget.dart';
import 'package:crud/app/pages/users_list/widgets/user_card.dart';
import 'package:flutter/material.dart';

abstract class ListState {
  Widget render();
}

class LoadedList extends ListState {
  List<User> users;
  LoadedList(this.users);

  @override
  Widget render() {
    return SingleChildScrollView(
      child: Column(
        children: users.map<Widget>((e) => UserCard(user: e)).toList(),
      ),
    );
  }
}

class ErrorList extends ListState {
  Exception error;
  ErrorList(this.error);

  @override
  Widget render() {
    return ListErrorWidget(error: error);
  }
}

// class SuccessList extends ListState {}

class LoadingList extends ListState {
  @override
  Widget render() {
    return const CircularProgressIndicator();
  }
}
