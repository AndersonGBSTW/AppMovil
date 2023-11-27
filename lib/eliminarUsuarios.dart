// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EliminarUsuarios{

  String? id;

EliminarUsuarios({this.id,});

Future<void> eliminarUsuarios(BuildContext context) async {
  const String url = 'https://backend-valhalla.onrender.com/ruta/usuarios';
  final Map<String, dynamic> data = {
    '_id':id,
  };

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('Delete creado con éxito');
      // ignore: use_build_context_synchronously
    } else {
      print('Error al eliminar. Código de estado: ${response.statusCode} Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error durante la solicitud HTTP: $e');
  }
}
}