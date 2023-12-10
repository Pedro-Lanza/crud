import 'package:flutter_validator/flutter_validator.dart';

extension AppValidator on Validator {
  Validator baseValidator() {
    return copy().isNotEmpty(
      message: 'O campo é obrigatório',
    );
  }

  Validator cpfValidator() {
    return baseValidator().minLength(
      11,
      message: 'CPF incompleto',
    );
  }

  Validator telefoneValidator() {
    return baseValidator().minLength(
      11,
      message: 'Telefone incompleto',
    );
  }
}
