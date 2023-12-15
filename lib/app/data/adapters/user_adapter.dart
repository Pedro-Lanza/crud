import 'package:crud/app/data/models/user_entity.dart';

class UserAdapter {
  static User fromMap(Map<dynamic, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surName: map['surname'],
      image: map['image'],
      details: map['details'],
    );
  }

  static Map<String, dynamic> toMap(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'surname': user.surName,
      'image': user.image,
      'details': user.details,
    };
  }
}
