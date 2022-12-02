import 'package:api_propia/paginas/cadastro.dart';
import 'package:api_propia/paginas/cadastro_cidade.dart';
import 'package:api_propia/paginas/cidades.dart';
import 'package:api_propia/paginas/consulta.dart';
import 'package:api_propia/paginas/home.dart';
import 'package:api_propia/util/tema.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema().criaTema(),
      initialRoute: '/home',
      routes: {
        '/home':(context) => const Home(),
        '/consulta': (context) => const Consulta(),
        '/cadastro': (context) => const Cadastro(),
        '/cidades':(context) => const Cidades(),
        '/cadastro_cidades': (context) => const CadastroCidade(),
      },
    );
  }
}
