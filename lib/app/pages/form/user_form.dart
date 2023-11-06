import 'package:crud/app/pages/form/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserForm extends StatelessWidget {
  //UserForm({super.key});
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    var txt = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Icon(Icons.person, size: 80),
              ),
              Row(
                children: [
                  Flexible(
                    child: InputField(
                      onSaved: (val) {
                        formData['name'] = val;
                      },
                      label: "Nome",
                      hint: "Insira nome",
                      icon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: InputField(
                      onSaved: (val) {
                        formData['surname'] = val;
                      },
                      label: "Sobrenome",
                      hint: "Insira sobrenome",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InputField(
                onSaved: (val) {
                  formData['description'] = val;
                },
                label: "Descrição",
                hint: "Insira descrição",
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: txt,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        formData['birth'] = val;
                      },
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );

                        if (date != null) {
                          txt.text = DateFormat("dd/MM/yyyy").format(date);
                        }
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_month_outlined),
                        labelText: 'Data de Nascimento',
                        hintText: 'XX/XX/XXXX',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("Private:"),
                  Checkbox(
                    value: false,
                    onChanged: (val) {
                      formData['private'] = val;
                    },
                  )
                ],
              ),
              const SizedBox(height: 30),
              TextButton(
                child: const Text("save"),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
