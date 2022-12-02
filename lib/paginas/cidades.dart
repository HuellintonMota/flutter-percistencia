import 'package:api_propia/api/acesso_api.dart';
import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/util/componentes.dart';
import 'package:flutter/material.dart';

class Cidades extends StatefulWidget {
  const Cidades({super.key});

  @override
  State<Cidades> createState() => _CidadesState();
}

class _CidadesState extends State<Cidades> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  GlobalKey<FormState> formUF = GlobalKey<FormState>();
  TextEditingController txtUF = TextEditingController();
  List<Cidade> lista = [];

  listarTodas() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }
  listarPorUf() async {
    List<Cidade> cidades = await AcessoApi().listaCidadesPorUf(txtUF.text);
    setState(() {
      lista = cidades;
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

    cadastro() {
      Navigator.of(context).pushNamed('/cadastro');
    }

    consulta() {
      Navigator.of(context).pushNamed('/consulta');
    }

    cidades() {
      Navigator.of(context).pushNamed('/cidades');
    }

    cadastroCidades() {
      Navigator.pushNamed(context, '/cadastro_cidades',
          arguments: Cidade(0, "", ""));
    }

    return Scaffold(
      appBar: Componentes(context).criaAppBar('Cidades', home, listarTodas),
      floatingActionButton: FloatingActionButton(
          onPressed: cadastroCidades,
          tooltip: "Novo",
          child: const Icon(Icons.add)),
      drawer: Componentes(context).criaDrawer(consulta, cidades, null, txtUF, formUF, listarPorUf),

      body: Form(
        key: formController,
        child: Column(
          children: [
            // Componentes(context)
            //     .criaBotao(formController, listarTodas, "Listar Cidades"),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(5),
                    child: Componentes(context).criaItemCidade(lista[index]),
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
