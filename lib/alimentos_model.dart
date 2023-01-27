// To parse this JSON data, do
//
//     final alimento = alimentoFromJson(jsonString);

import 'dart:convert';

Alimento alimentoFromJson(String str) => Alimento.fromJson(json.decode(str));

String alimentoToJson(Alimento data) => json.encode(data.toJson());

class Alimento {
  Alimento({
    required this.id,
    required this.nombre,
    required this.porcion,
    required this.caloria,
    required this.grasa,
    required this.carbohidrato,
    required this.proteina,
    required this.fuente,
    required this.url,
    this.contador = 1.0,
    this.contadorCarbohidratos = 0.0,
  });

  int id;
  String nombre;
  String porcion;
  String caloria;
  String grasa;
  String carbohidrato;
  String proteina;
  String fuente;
  String url;
  double contador;
  double contadorCarbohidratos;

  factory Alimento.fromJson(Map<String, dynamic> json) => Alimento(
        id: json["id"],
        nombre: json["nombre"],
        porcion: json["porcion"],
        caloria: json["caloria"],
        grasa: json["grasa"],
        carbohidrato: json["carbohidrato"],
        proteina: json["proteina"],
        fuente: json["fuente"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "porcion": porcion,
        "caloria": caloria,
        "grasa": grasa,
        "carbohidrato": carbohidrato,
        "proteina": proteina,
        "fuente": fuente,
        "url": url,
      };
}
