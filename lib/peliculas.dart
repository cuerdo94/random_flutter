import 'package:flutter/material.dart';
import 'dart:math' as math;

class Peliculas extends StatefulWidget {
  const Peliculas({super.key});

  @override
  State<Peliculas> createState() => _PeliculasState();
}

class _PeliculasState extends State<Peliculas> {
  List<Color> peliculas = List<Color>.generate(
      15,
      (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0));
  List<Color> sugeridos = List<Color>.generate(
      8,
      (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(0.5));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/one.jpg',
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: peliculas.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return cardPeliculas(index);
                  }),
            ),
            const Text('Peliculas vistas los ultimos 15 días'),
            SizedBox(
              height: 150,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sugeridos.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return cardSugeridos(index);
                  }),
            ),
          ],
        ),
      )),
    );
  }

  Padding cardSugeridos(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 150,
              color: sugeridos[index],
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Pelicula $index'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('TIPO PELICULA  $index'),
          )
        ],
      ),
    );
  }

  Padding cardPeliculas(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 150,
              color: peliculas[index],
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Pelicula $index'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('TIPO PELICULA  $index'),
          )
        ],
      ),
    );
  }
}
