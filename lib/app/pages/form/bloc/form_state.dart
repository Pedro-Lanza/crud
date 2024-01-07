sealed class FormStates {}

final class LoadedForm extends FormStates {
  Map<String, dynamic> formData;

  LoadedForm(this.formData);
}

final class LoadingForm extends FormStates {
  LoadingForm();
}

final class ErrorForm extends FormStates {
  Exception error;
  ErrorForm(this.error);
}

final class DialogForm extends FormStates {
  Exception error;
  DialogForm(this.error);
}

final class SuccessfulForm extends FormStates {}
