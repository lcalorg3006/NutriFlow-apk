import 'package:flutter/material.dart';
import 'package:nutriflow_app/models/comidas.dart';
import 'package:nutriflow_app/models/hidratos_de_carbono.dart';

class Comidacard extends StatelessWidget {
  const Comidacard(
      {super.key,
      required this.titulo,
      required this.hidratos,
      required this.comidas});
  
  final String titulo;
  final HidratosDeCarbono hidratos;
  final List<Comida> comidas;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, 
              color: Colors.green,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$titulo - total_calorias ${hidratos.total_calorias} cal",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white, 
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Grasas: ${hidratos.total_grasas} g | Proteínas: ${hidratos.total_proteinas} g | Hidratos: ${hidratos.total_hidratos} g",
                        style: const TextStyle(
                          color: Colors.white, 
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white), 
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: comidas
                  .map((comida) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comida.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  comida.cantidad,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              "${comida.calorias} calorias",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              "${comida.grasas} grasas",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "${comida.proteinas} proteinas",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}