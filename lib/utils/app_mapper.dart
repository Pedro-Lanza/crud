import 'package:crud/app/exceptions/mapper_exception.dart';

abstract final class AppMapper {
  static T parse<T>(
    String arg,
    T Function() resolver,
  ) {
    try {
      return resolver();
    } catch (e) {
      throw MapperException(
        message: '[ AppMapper ] Error when parsing the key: $arg | $e',
      );
    }
  }
}
