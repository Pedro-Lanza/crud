import 'package:crud/app/data/models/details_entity.dart';
import 'package:crud/app/data/models/user_entity.dart';
import 'package:crud/app/mask/input_masks.dart';
import 'package:crud/app/pages/form/bloc/form_bloc.dart';
import 'package:crud/app/pages/form/bloc/form_event.dart';
import 'package:crud/app/pages/form/widgets/input_field.dart';
import 'package:crud/app/validators/input_validators.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validator/flutter_validator.dart';
import 'package:intl/intl.dart';

class FormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData;
  final Validator validator = const Validator();
  final dynamic txt;

  FormWidget({super.key, required this.formData, this.txt});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: (formData['image'] == null)
                ? const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(formData['image']),
                  ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Flexible(
                child: InputField(
                  initialValue: formData['name'],
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
                  initialValue: formData['surname'],
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
            initialValue: formData['description'],
            onSaved: (val) {
              formData['description'] = val;
            },
            label: "Descrição",
            hint: "Insira descrição",
          ),
          const SizedBox(height: 20),
          InputField(
            initialValue: formData['cpf'],
            onSaved: (val) {
              formData['cpf'] = val;
            },
            inputFormatters: InputMask.cpfMask(),
            validator: validator.cpfValidator(),
            label: "CPF",
            hint: "Insira CPF",
          ),
          const SizedBox(height: 20),
          InputField(
            initialValue: formData['telefone'],
            onSaved: (val) {
              formData['telefone'] = val;
            },
            inputFormatters: InputMask.phoneMask(),
            validator: validator.telefoneValidator(),
            label: "Telefone",
            hint: "Insira telefone",
          ),
          const SizedBox(height: 40),
          DropdownButtonFormField(
            value: formData['gender'],
            decoration: const InputDecoration(
              labelText: "genero",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                  right: Radius.circular(10),
                ),
              ),
            ),
            hint: const Text("genero"),
            items: const [
              DropdownMenuItem(value: "nada a declarar", child: Text("nada a declarar")),
              DropdownMenuItem(value: "masculino", child: Text("masculino")),
              DropdownMenuItem(value: "feminino", child: Text("feminino")),
              DropdownMenuItem(value: "outro", child: Text("outro")),
            ],
            onChanged: (val) {},
            onSaved: (val) {
              formData['gender'] = val;
            },
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: txt,
                  validator: validator.baseValidator(),
                  onSaved: (val) {
                    formData['birth'] = val;
                  },
                  inputFormatters: [
                    TextInputMask(
                      mask: ['99/99/9999])'],
                      reverse: false,
                    )
                  ],
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
                value: formData['private'],
                onChanged: (val) {
                  formData['private'] = val;
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          TextButton(
            child: const Text("save"),
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();
              Details detail = Details(
                id: formData['id'],
                user: formData['id'],
                description: formData['description'],
                birth: DateFormat('dd/MM/yyyy').parse(formData['birth']),
                private: formData['private'],
                gender: formData['gender'],
                cpf: formData['cpf'],
                telefone: formData['telefone'],
              );

              var usr = User(
                id: formData['id'],
                name: formData['name'],
                surName: formData['surname'],
                image: 'https://i.pinimg.com/736x/70/3f/cd/703fcdbe33b1176f9e9db8fb7ce9950a.jpg',
                details: detail.id!,
              );

              context.read<FormBloc>().add(AddUser(usr, detail, context));
            },
          ),
        ],
      ),
    );
  }
}
