import 'package:api_propia/api/acesso_api.dart';
import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/model/pessoa.dart';
import 'package:api_propia/util/componentes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int qtPessoas = 0;
  int qtCidades = 0;

  contaCadastros() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    List<Pessoa> pessoas = await AcessoApi().listaPessoas();

    setState(() {
      qtPessoas = pessoas.length;
      qtCidades = cidades.length;
    });
  }
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  void initState() {
    contaCadastros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastro() {
      Navigator.of(context).pushNamed('/cadastro');
    }

    consulta() {
      Navigator.of(context).pushNamed('/consulta');
    }

    cidades() {
      Navigator.of(context).pushNamed('/cidades');
    }

    return Scaffold(
      appBar: Componentes(context).criaAppBar('Utilização API', home),
      drawer: Componentes(context).criaDrawer(consulta, cidades,null,null),
      body: Form(
        key: formController,
        child: ListView(
          children: [
            Componentes(context)
                .criaItemHome(qtPessoas, 'Pessoas Cadastradas', '/consulta'),
            Componentes(context)
                .criaItemHome(qtCidades, 'Cidades Cadastradas', '/cidades'),
          ],
        ),
      ),
      // body: Form(
      //   key: formController,
      //   child: Column(
      //     children: [
      //       Componentes(context)
      //           .criaBotao(formController, cadastro, "Cadastro Pessoa"),
      //       Componentes(context)
      //           .criaBotao(formController, consulta, "Consulta Pessoa"),

      //     ],
      //   ),
      // ),
    );
  }
}
