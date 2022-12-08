import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/model/pessoa.dart';
import 'package:api_propia/util/combo_cidade.dart';
import 'package:api_propia/util/combo_uf.dart';
import 'package:flutter/material.dart';

class Componentes {
  BuildContext context;

  Componentes(this.context);

  criaAppBar(texto, home, [refresh]) {
    return AppBar(
      title: criaTexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          onPressed: home,
          icon: const Icon(Icons.home),
        ),
        refresh != null
            ? IconButton(
                onPressed: refresh,
                icon: const Icon(Icons.refresh),
              )
            : const SizedBox(
                height: 1,
              ),
      ],
    );
  }

  criaFiltroCidade([Key? key, txtCidade, funcao]) {
    return Form(
      key: key,
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Column(
          children: [
            Center(child: ComboCidade(controller: txtCidade)),
            criaBotao(key, funcao, 'Buscar')
          ],
        ),
      ),
    );
  }

  criaFiltroUF(Key? key, controllerUF, funcao) {
    return Form(
      key: key,
      child: Column(
          children: [
            ComboUF(controller: controllerUF,),
            criaBotao(key, funcao, 'Buscar')
          ],
        
      ),
    );
  }

  criaTexto(texto, [tamanho, cor]) {
    if (cor != null) {
      return Text(
        texto,
        style: TextStyle(color: cor, fontSize: double.parse('$tamanho')),
      );
    } else {
      return Text(texto);
    }
  }

  iconeGrande() {
    return const Icon(
      Icons.maps_home_work_outlined,
      size: 180,
    );
  }

  criaInputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao,
      [bool enabled = true]) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: tipoTeclado,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: textoEtiqueta,
          labelStyle: const TextStyle(fontSize: 20),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controlador,
        validator: (value) {
          if (value!.isEmpty && enabled) {
            return msgValidacao;
          }
        },
      ),
    );
  }

  criaBotao(controladorFormulario, funcao, titulo) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                if (controladorFormulario.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  criaContainerDados(rua, complemento, bairro, cidade, estado) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: criaTexto(rua, Colors.black)),
            Expanded(flex: 1, child: criaTexto(complemento, Colors.black)),
            Expanded(flex: 1, child: criaTexto(bairro, Colors.black)),
            Expanded(flex: 1, child: criaTexto(cidade, Colors.black)),
            Expanded(flex: 1, child: criaTexto(estado, Colors.black)),
          ],
        ),
      ),
    );
  }

  criaDrawer(irClientes, irCidades, txtCidade,txtUf,[Key? formCidade ,funcao]) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            child: criaTexto(
                "Menu", 15, Theme.of(context).colorScheme.onSecondary),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Clientes'),
            onTap: irClientes,
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: const Text('Cidades'),
            onTap: irCidades,
          ),
          txtCidade!=null?ListTile(
            title: criaFiltroCidade(formCidade,txtCidade, funcao),
          ):const SizedBox(height: 1,),
          txtUf!=null?ListTile(
            title: criaFiltroUF(formCidade,txtUf,funcao),
          ):const SizedBox(height: 1,),
        ],
      ),
    );
  }

  criaItemPessoa(
    Pessoa p,
  ) {
    String sexo = p.sexo == 'M' ? 'Masculino' : 'Feminino';
    return ListTile(
      title: criaTexto("${p.id} - ${p.nome}"),
      subtitle: criaTexto("${p.idade} anos - ($sexo)"),
      trailing: criaTexto("${p.cidade.nome}/${p.cidade.uf}"),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/cadastro',
          arguments: p,
        );
      },
    );
  }

  criaItemCidade(Cidade c) {
    return ListTile(
      title: criaTexto("${c.nome} - ${c.uf}"),
      subtitle: criaTexto("ID: ${c.id}"),
      onTap: () {
        Navigator.pushNamed(context, '/cadastro_cidades', arguments: c);
      },
    );
  }

  criaItemHome(int qt, String titulo, funcao) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListTile(
              title: criaTexto(titulo),
              leading: CircleAvatar(
                child: criaTexto("$qt"),
              ),
              onTap: () => Navigator.of(context).pushNamed(funcao),
            ),
          ),
        ],
      ),
    );
  }
}
