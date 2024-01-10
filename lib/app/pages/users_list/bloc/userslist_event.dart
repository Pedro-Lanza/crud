abstract class ListEvent {}

class FetchUsers extends ListEvent {}

class DeleteUser extends ListEvent {
  int id;

  DeleteUser(this.id);
}
