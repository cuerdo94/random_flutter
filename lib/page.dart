// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:buscar_y_listar/alimentos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  ValueNotifier<TextEditingController> busqueda =
      ValueNotifier(TextEditingController(text: ''));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Lista de alimentos'),
            backgroundColor: Colors.blueGrey,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: busqueda.value,
                  decoration: const InputDecoration(label: Text('Busqueda')),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: busqueda,
                    builder: (BuildContext context, value, Widget? child) {
                      return FutureBuilder(
                        future: alimentos(context, busqueda.value.text),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Alimento>> snapshot) {
                          return snapshot.data!.isEmpty
                              ? const Center(
                                  child: Text('No hay data'),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(snapshot.data![index].nombre),
                                    );
                                  },
                                );
                        },
                      );
                    }),
              )
            ],
          )),
    );
  }

  Future<List<Alimento>> alimentos(
      BuildContext context, String busqueda) async {
    List<Alimento> alimentos = [];
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 56xv8b1rwqawxxnmly74awjeqlmhdg7ygh82tvh3sezlogc95q0ntww6r93tqq9p3olkwdo5n9t3y7p3o0by6q6ls7lzaoiwnsq0ad8oumz32rtml7hcekzqqgmfwds2m8jfly2tpbe47r89kn6y62b4fk7cwa7qw7rym8ohstkkpo1tuhqao8j87zj1vvzt4b9bjwln'
    };
    var request = http.Request(
        'POST', Uri.parse('https://diabetips.cl/api/v1/alimentos/buscar'));
    request.body = json.encode({"alimento": busqueda});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(jsonDecode(await response.stream.bytesToString())['body']);
      for (var item
          in jsonDecode(await response.stream.bytesToString())['body']) {
        alimentos.add(Alimento.fromJson(item));
        // mensajeSnack(context, "Busqueda exitosa");
      }
    } else {
      // mensajeSnack(context, "No se encontraron elementos");
    }
    return alimentos;
  }
}

void mensajeSnack(BuildContext context, String mensaje,
    {Duration duracion = const Duration(seconds: 2),
    Color colorFondo = Colors.blueAccent}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: colorFondo,
        duration: duracion,
        content: Text(mensaje)),
  );
}
