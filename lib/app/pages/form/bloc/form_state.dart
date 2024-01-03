import 'package:crud/app/pages/form/widgets/error_widget.dart';
import 'package:crud/app/pages/form/widgets/form_widget.dart';
import 'package:flutter/material.dart';

abstract class FormStates {
  Widget render();
}

class LoadedForm extends FormStates {
  Map<String, dynamic> formData;
  dynamic txt;

  LoadedForm(this.formData, this.txt);

  @override
  Widget render() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormWidget(formData: formData, txt: txt),
    );
  }
}

class LoadingForm extends FormStates {
  LoadingForm();
  @override
  Widget render() {
    return const CircularProgressIndicator();
  }
}

class ErrorForm extends FormStates {
  Exception error;
  ErrorForm(this.error);

  @override
  Widget render() {
    return FormErrorWidget(error: error);
  }
}
