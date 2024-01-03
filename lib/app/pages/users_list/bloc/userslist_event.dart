import 'package:flutter/material.dart';

abstract class ListEvent {}

class FetchUsers extends ListEvent {}

class DeleteUser extends ListEvent {
  int id;
  BuildContext context;

  DeleteUser(this.context, this.id);
}
