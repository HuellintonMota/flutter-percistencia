import 'package:flutter/material.dart';

enum SexoEnum { masculino, feminino }

class RadioSexo extends StatefulWidget {
  TextEditingController? controller;
  RadioSexo({Key? key, this.controller}) : super(key: key);

  @override
  State<RadioSexo> createState() => _RadioSexoState();
}

class _RadioSexoState extends State<RadioSexo> {
  SexoEnum? _escolha = SexoEnum.masculino;

  @override
  Widget build(BuildContext context) {
    _escolha = widget.controller?.text == 'M' ? SexoEnum.masculino : SexoEnum.feminino;
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text("Masculino"),
            leading: Radio(
                value: SexoEnum.masculino,
                groupValue: _escolha,
                onChanged: (SexoEnum? value) {
                  setState(() {
                    _escolha = value;
                    widget.controller?.text = 'M';
                  });
                }),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text("Feminino"),
            leading: Radio(
                value: SexoEnum.feminino,
                groupValue: _escolha,
                onChanged: (SexoEnum? value) {
                  setState(() {
                    _escolha = value;
                    widget.controller?.text = 'F';
                  });
                }),
          ),
        ),
      ],
    );
  }
}
