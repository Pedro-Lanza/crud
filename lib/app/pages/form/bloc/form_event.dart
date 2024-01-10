import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';

abstract class FormEvent {}

class AddUser extends FormEvent {
  User user;
  Details details;

  AddUser(this.user, this.details);
}

class LoadForm extends FormEvent {
  User? user;

  LoadForm(this.user);
}
