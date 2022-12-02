import 'package:api_propia/api/acesso_api.dart';
import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/model/pessoa.dart';
import 'package:api_propia/util/componentes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  State<Consulta> createState() => _ConsultaState();
}

Pessoa? pessoaSelecionada;

class _ConsultaState extends State<Consulta> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  GlobalKey<FormState> formCidade = GlobalKey<FormState>();
  TextEditingController txtCidade = TextEditingController();
  List<Pessoa> lista = [];

  listarTodas() async {
    List<Pessoa> pessoas = await AcessoApi().listaPessoas();
    setState(() {
      lista = pessoas;
    });
  }

  listarPorCidade() async {
    int idCid = int.parse(txtCidade.text);
    List<Pessoa> pessoas = await AcessoApi().listaPessoasPorCidade(idCid);
    setState(() {
      lista = pessoas;
    });
  }

  @override
  void initState() {
    listarTodas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cidades() {
      Navigator.of(context).pushNamed('/cidades');
    }

    cadastro() {
      Navigator.pushNamed(context, '/cadastro',
          arguments: Pessoa(0, "", "M", 0, Cidade(0, "", "")));
    }

    return Scaffold(
      appBar:
          Componentes(context).criaAppBar("Utilização API", home, listarTodas),
      drawer: Componentes(context).criaDrawer(null, cidades, txtCidade, null, formCidade,listarPorCidade),
      floatingActionButton: FloatingActionButton(
          onPressed: cadastro, tooltip: "Novo", child: const Icon(Icons.add)),
      body: Form(
        key: formController,
        child: Column(
          children: [
            // Componentes(context)
            //     .criaBotao(formController, listarTodas, "Listar Todas"),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(5),
                    child: Componentes(context).criaItemPessoa(lista[index]),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
