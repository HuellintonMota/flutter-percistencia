import 'package:api_propia/api/acesso_api.dart';
import 'package:api_propia/model/cidade.dart';
import 'package:flutter/material.dart';

class ComboCidade extends StatefulWidget {
  TextEditingController? controller;
  ComboCidade({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboCidade> createState() => _ComboCidadeState();
}

class _ComboCidadeState extends State<ComboCidade> {
  @override
  Widget build(BuildContext context) {
    int? cidadesel;
    if (widget.controller != null && widget.controller?.text != null) {
      String idCid = '${widget.controller?.text}';
      if(idCid!='0'&&idCid.isNotEmpty){
        cidadesel = int.parse(idCid);
      }
      // print(idCid);
    }
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 0))
          .then((value) => AcessoApi().listaCidades()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Cidade> cidades = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton(
              isExpanded: true,
              value: cidadesel,
              icon: const Icon(Icons.arrow_drop_down),
              hint: const Text("Selecione uma cidade....."),
              elevation: 16,
              onChanged: (int? value) {
                setState(() {
                  cidadesel = value;
                  // print('$value');
                  widget.controller?.text = "$value";
                });
              },
              items: cidades.map<DropdownMenuItem<int>>((Cidade cid) {
                return DropdownMenuItem<int>(
                    value: cid.id, child: Text("${cid.nome}/${cid.uf}"));
              }).toList(),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Carregando Cidades'),
            ],
          );
        }
      },
    );
  }
}
