import 'package:crud/app/data/models/details_entity.dart';

class DetailsAdapter {
  DetailsAdapter();

  static Details fromMap(Map<dynamic, dynamic> map) {
    return Details(
      id: map['id'],
      user: map['user'],
      description: map['description'],
      birth: map['birth'],
      private: map['private'],
      gender: map['gender'],
      cpf: map['cpf'],
      telefone: map['telefone'],
    );
  }

  static Map<String, dynamic> toMap(Details details) {
    return {
      'id': details.id,
      'user': details.user,
      'description': details.description,
      'birth': details.birth,
      'private': details.private,
      'gender': details.gender,
      'cpf': details.cpf,
      'telefone': details.telefone,
    };
  }
}
