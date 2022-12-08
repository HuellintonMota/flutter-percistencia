import 'dart:convert';

import 'package:api_propia/model/cidade.dart';
import 'package:api_propia/model/pessoa.dart';
import 'package:http/http.dart';

class AcessoApi {
  // String server = 'http://ec2-3-89-98-186.compute-1.amazonaws.com:8080/';
  String server = 'http://localhost:8080';

  Future<List<Pessoa>> listaPessoas() async {
    String url = '$server/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }

  Future<List<Pessoa>> listaPessoasPorCidade(int id) async {
    String url = '$server/cliente/buscacidade?id=$id';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
    return pessoas;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = '$server/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades = List<Cidade>.from(l.map((p) => Cidade.fromJson(p)));
    return cidades;
  }

  Future<List<Cidade>> listaCidadesPorUf(String uf) async {
    String url = '$server/cidade/buscauf/$uf';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadoUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadoUtf8);
    List<Cidade> cidades = List<Cidade>.from(l.map((p) => Cidade.fromJson(p)));
    return cidades;
  }

  Future<void> inserePessoa(Map<String, dynamic> pessoa) async {
    String url = '$server/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = '$server/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> alteraPessoa(Map<String, dynamic> pessoa) async {
    Pessoa p = Pessoa.fromJson(pessoa);
    String url = '$server/cliente?id=${p.id}';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    Cidade c = Cidade.fromJson(cidade);
    String url = '$server/cidade?id=${c.id}';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> excluirCidade(int id) async {
    String url = '$server/cidade/$id';
    await delete(Uri.parse(url));
  }

  Future<void> excluirPessoa(int id) async {
    String url = '$server/cliente/$id';
    await delete(Uri.parse(url));
  }
}
