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

class FormWidget extends StatefulWidget {
  final Map<String, dynamic> formData;

  FormWidget({super.key, required this.formData});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Validator validator = const Validator();
  late dynamic txt;

  @override
  void initState() {
    super.initState();
    txt = TextEditingController(text: widget.formData['birth'] != null ? DateFormat("dd/MM/yyyy").format(widget.formData['birth']) : null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: (widget.formData['image'] == null)
                  ? const CircleAvatar(
                      child: Icon(
                        Icons.person,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(widget.formData['image']),
                    ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Flexible(
                  child: InputField(
                    initialValue: widget.formData['name'],
                    onSaved: (val) {
                      widget.formData['name'] = val;
                    },
                    label: "Nome",
                    hint: "Insira nome",
                    icon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: InputField(
                    initialValue: widget.formData['surname'],
                    onSaved: (val) {
                      widget.formData['surname'] = val;
                    },
                    label: "Sobrenome",
                    hint: "Insira sobrenome",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InputField(
              initialValue: widget.formData['description'],
              onSaved: (val) {
                widget.formData['description'] = val;
              },
              label: "Descrição",
              hint: "Insira descrição",
            ),
            const SizedBox(height: 20),
            InputField(
              initialValue: widget.formData['cpf'],
              onSaved: (val) {
                widget.formData['cpf'] = val;
              },
              inputFormatters: InputMask.cpfMask(),
              validator: validator.cpfValidator(),
              label: "CPF",
              hint: "Insira CPF",
            ),
            const SizedBox(height: 20),
            InputField(
              initialValue: widget.formData['telefone'],
              onSaved: (val) {
                widget.formData['telefone'] = val;
              },
              inputFormatters: InputMask.phoneMask(),
              validator: validator.telefoneValidator(),
              label: "Telefone",
              hint: "Insira telefone",
            ),
            const SizedBox(height: 40),
            DropdownButtonFormField(
              value: widget.formData['gender'],
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
                widget.formData['gender'] = val;
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
                      widget.formData['birth'] = val;
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
                  value: widget.formData['private'],
                  onChanged: (val) {
                    widget.formData['private'] = val;
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
                  id: widget.formData['id'],
                  user: widget.formData['id'],
                  description: widget.formData['description'],
                  birth: DateFormat('dd/MM/yyyy').parse(widget.formData['birth']),
                  private: widget.formData['private'],
                  gender: widget.formData['gender'],
                  cpf: widget.formData['cpf'],
                  telefone: widget.formData['telefone'],
                );

                var usr = User(
                  id: widget.formData['id'],
                  name: widget.formData['name'],
                  surName: widget.formData['surname'],
                  image: 'https://i.pinimg.com/736x/70/3f/cd/703fcdbe33b1176f9e9db8fb7ce9950a.jpg',
                  details: detail.id!,
                );

                context.read<FormBloc>().add(AddUser(usr, detail, context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
