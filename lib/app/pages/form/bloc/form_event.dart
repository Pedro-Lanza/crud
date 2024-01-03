import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:flutter/material.dart';

abstract class FormEvent {}

class AddUser extends FormEvent {
  User user;
  Details details;
  BuildContext context;

  AddUser(this.user, this.details, this.context);
}

class LoadForm extends FormEvent {
  User? user;

  LoadForm(this.user);
}
