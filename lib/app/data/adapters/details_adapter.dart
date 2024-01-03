import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/utils/app_mapper.dart';

class DetailsAdapter {
  DetailsAdapter();

  static Details fromMap(Map<dynamic, dynamic> map) {
    return Details(
      id: AppMapper.parse('id', () => map['id']),
      user: AppMapper.parse('user', () => map['user']),
      description: AppMapper.parse('description', () => map['description']),
      birth: AppMapper.parse('birth', () => map['birth']),
      private: AppMapper.parse('private', () => map['private']),
      gender: AppMapper.parse('gender', () => map['gender']),
      cpf: AppMapper.parse('cpf', () => map['cpf']),
      telefone: AppMapper.parse('telefone', () => map['telefone']),
    );
  }

  static Map<String, dynamic> toMap(Details details) {
    return {
      'id': AppMapper.parse('id', () => details.id),
      'user': AppMapper.parse('user', () => details.user),
      'description': AppMapper.parse('description', () => details.description),
      'birth': AppMapper.parse('birth', () => details.birth),
      'private': AppMapper.parse('private', () => details.private),
      'gender': AppMapper.parse('gender', () => details.gender),
      'cpf': AppMapper.parse('cpf', () => details.cpf),
      'telefone': AppMapper.parse('telefone', () => details.telefone),
    };
  }
}
