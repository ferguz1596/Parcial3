import 'dart:convert';
import 'package:flutter/material.dart';
import 'modelos/fotos.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Parcial3());
}

class Parcial3 extends StatefulWidget {
  Parcial3({Key? key}) : super(key: key);

  @override
  State<Parcial3> createState() => _Parcial3State();
}

class _Parcial3State extends State<Parcial3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "parcial 3",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Fotos>> _listadoFotos;

  List<Fotos> lista = [];

  Future<List<Fotos>> _getFotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var item in jsonData) {
        lista.add(Fotos(item["albumId"], item["id"], item["title"], item["url"],
            item["thumbnailUrl"]));
      }

      return lista;
    } else {
      throw Exception("Error de conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoFotos = _getFotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parcial 3"),
      ),
      body: Boby(),
    );
  }

  Widget Boby() {
    return FutureBuilder(
        future: _listadoFotos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _listadoFoto(snapshot.data),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  List<Widget> _listadoFoto(data) {
    List<Widget> listado = [];

    for (var list in data) {
      listado.add(
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: Text(list.albumId.toString())),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: Text(list.title.toString())),
              ),
              Image.network(list.url.toString())
            ],
          ),
        ),
      );
    }

    return listado;
  }
}
