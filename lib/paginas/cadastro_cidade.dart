import 'package:api_propia/api/acesso_api.dart';
import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/util/combo_uf.dart';
import 'package:api_propia/util/componentes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CadastroCidade extends StatefulWidget {
  const CadastroCidade({super.key});

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();
  TextEditingController txtId = TextEditingController();
  home() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  cadastro() {
    Navigator.of(context).pushReplacementNamed('/cadastro');
  }

  consulta() {
    Navigator.of(context).pushReplacementNamed('/consulta');
  }

  cidades() {
    Navigator.of(context).pushReplacementNamed('/cidades');
  }

  cadastrar() {
    Cidade c = Cidade(0, txtNome.text, txtUf.text);
    AcessoApi().insereCidade(c.toJson());
    Navigator.of(context).pushReplacementNamed('/cidades');
  }

  alterar() {
    Cidade c = Cidade(
        txtId.text != '' ? int.parse(txtId.text) : 0, txtNome.text, txtUf.text);
    AcessoApi().alteraCidade(c.toJson());
    Navigator.of(context).pushReplacementNamed('/consulta');
  }

  abrirDialogo() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmar ação!!'),
        content: Text(
            'Tem certeza que quer excluir ${txtNome.text} - ${txtUf.text}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: excluir,
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  excluir() {
    int id = int.parse(txtId.text);
    AcessoApi().excluirCidade(id);
    cidades();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    setState(() {
      txtId.text = args.id == 0 ? '' : '${args.id}';
      txtNome.text = args.nome;
      txtUf.text = args.uf;
    });
    return Scaffold(
      appBar: Componentes(context).criaAppBar("Cadastro de Cidades", home),
      drawer: Componentes(context).criaDrawer(consulta, cidades,null,null),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes(context)
                .criaInputTexto(TextInputType.text, "ID", txtId, "ID", false),
            Componentes(context).criaInputTexto(
                TextInputType.text, "Nome", txtNome, "Informe o Nome"),
            // Combo UF
            Center(child: ComboUF(controller: txtUf)),
            Componentes(context).criaBotao(
                formController,
                txtId.text == "" ? cadastrar : alterar,
                txtId.text == "" ? "Cadastrar" : "Alterar"),
            txtId.text!=''?Componentes(context)
                .criaBotao(formController,  abrirDialogo, "Excluir"):const SizedBox(height: 1,),
          ],
        ),
      ),
    );
  }
}
