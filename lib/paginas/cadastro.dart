import 'package:api_propia/api/acesso_api.dart';
import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/model/pessoa.dart';
import 'package:api_propia/util/combo_cidade.dart';
import 'package:api_propia/util/componentes.dart';
import 'package:api_propia/util/radio_sexo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtId = TextEditingController();
  TextEditingController txtSexo = TextEditingController();
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  cadastrar() {
    Pessoa p = Pessoa(0, txtNome.text, txtSexo.text, int.parse(txtIdade.text),
        Cidade(int.parse(txtCidade.text), "", ""));
    AcessoApi().inserePessoa(p.toJson());
    Navigator.of(context).pushReplacementNamed('/consulta');
  }

  alterar() {
    Pessoa p = Pessoa(
        txtId.text != '' ? int.parse(txtId.text) : 0,
        txtNome.text,
        txtSexo.text,
        int.parse(txtIdade.text),
        Cidade(int.parse(txtCidade.text), "", ""));
    AcessoApi().alteraPessoa(p.toJson());
    Navigator.of(context).pushReplacementNamed('/consulta');
  }

  abrirDialogo() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmar ação!!'),
        content: Text('Tem certeza que quer excluir ${txtNome.text}?'),
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
    AcessoApi().excluirPessoa(id);
    Navigator.pushReplacementNamed(context, '/consulta');
  }

  home() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  cidades() {
    Navigator.of(context).pushReplacementNamed('/cidades');
  }

  consulta() {
    Navigator.of(context).pushReplacementNamed('/consulta');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Pessoa;
    setState(() {
      txtId.text = args.id == 0 ? '' : '${args.id}';
      txtNome.text = args.nome;
      txtSexo.text = args.sexo;
      txtIdade.text = args.idade == 0 ? '' : "${args.idade}";
      txtCidade.text = '${args.cidade.id}';
    });
    return Scaffold(
      appBar: Componentes(context).criaAppBar("Utilização API", home),
      drawer: Componentes(context).criaDrawer(consulta, cidades,null,null),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes(context)
                .criaInputTexto(TextInputType.text, "ID", txtId, "ID", false),
            Componentes(context).criaInputTexto(
                TextInputType.text, "Nome", txtNome, "Informe o Nome"),
            Componentes(context).criaInputTexto(
                TextInputType.number, "Idade", txtIdade, "Informe a idade"),
            Center(child: RadioSexo(controller: txtSexo)),
            Center(child: ComboCidade(controller: txtCidade)),
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
