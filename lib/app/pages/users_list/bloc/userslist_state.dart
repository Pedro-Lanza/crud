import 'package:crud/app/data/models/user_entity.dart';

sealed class ListState {}

final class LoadedList extends ListState {
  List<User> users;
  LoadedList(this.users);
}

final class DialogList extends ListState {
  Exception error;
  DialogList(this.error);
}

final class SuccessList extends ListState {}

final class ErrorList extends ListState {
  Exception error;
  ErrorList(this.error);
}

// class SuccessList extends ListState {}

final class LoadingList extends ListState {}
