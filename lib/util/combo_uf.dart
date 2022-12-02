import 'package:flutter/material.dart';

class ComboUF extends StatefulWidget {
  TextEditingController? controller;
  ComboUF({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboUF> createState() => _ComboUFState();
}

class _ComboUFState extends State<ComboUF> {
  @override
  Widget build(BuildContext context) {
    String? ufSel;
    if ('${widget.controller?.text}'.isNotEmpty) {
      ufSel = widget.controller?.text;
    }
    List<String> ufs = [
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO'
    ];
    List<DropdownMenuItem<String>> itens = [];
    for (var uf in ufs) {
      itens.add(DropdownMenuItem<String>(value: uf, child: Text(uf)));
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButton<String>(
        isExpanded: true,
        value: ufSel,
        icon: const Icon(Icons.arrow_drop_down),
        hint: const Text("Selecione uma UF....."),
        elevation: 16,
        onChanged: (String? value) {
          setState(() {
            ufSel = value;
            widget.controller?.text = "$value";
          });
        },
        items: itens,
      ),
    );
  }
}
