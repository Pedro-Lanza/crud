import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/utils/app_mapper.dart';

class UserAdapter {
  static User fromMap(Map<dynamic, dynamic> map) {
    return User(
      id: AppMapper.parse('id', () => map['id']),
      name: AppMapper.parse('name', () => map['name']),
      surName: AppMapper.parse('surname', () => map['surname']),
      image: AppMapper.parse('image', () => map['image']),
      details: AppMapper.parse('details', () => map['details']),
    );
  }

  static Map<String, dynamic> toMap(User user) {
    return {
      'id': AppMapper.parse('id', () => user.id),
      'name': AppMapper.parse('name', () => user.name),
      'surname': AppMapper.parse('surname', () => user.surName),
      'image': AppMapper.parse('image', () => user.image),
      'details': AppMapper.parse('details', () => user.details),
    };
  }
}
