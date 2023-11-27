// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Alert.dart';
import 'package:http/http.dart' as http;

class InsertarUsuarios extends StatefulWidget {
  const InsertarUsuarios({super.key});
  @override
  State<InsertarUsuarios> createState() => _InsertarUsuariosState();
}

class _InsertarUsuariosState extends State<InsertarUsuarios> {
  TextEditingController nombres = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController rol = TextEditingController();
  TextEditingController estado = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertarUsuarios() async {
  const String url = 'https://backend-valhalla.onrender.com/ruta/usuarios';

  final Map<String, dynamic> data = {
    'nombres': nombres.text,
    'apellidos': apellidos.text,
    'username': usuario.text,
    'correo': correo.text,
    'rol': rol.text,
    'estado': estado.text,
    'password': password.text,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    print('Solicitud: ${json.encode(data)}');

    if (response.statusCode == 200) {
      print('Post creado con éxito');
    } else {
      print('Error al crear el post. Código de estado: ${response.statusCode} Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error durante la solicitud HTTP: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formInsertar = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Insertar Usuarios'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formInsertar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: nombres,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese Nombres',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: apellidos,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese Apellidos',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                   style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: usuario,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese nombre del Usuario',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: correo,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese correo',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                   style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: rol,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese el rol',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: estado,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese el estado',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                   style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: password,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese el password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!formInsertar.currentState!.validate()) {
                          return;
                        }
                    bool confirmacion= await Alertas.insertarAlerta(context,"Agregar Usuario","Estas seguro de agregar este usuario?");
                    if(confirmacion){
                        insertarUsuarios();
                        // ignore: use_build_context_synchronously
                        Alertas.insertarAlertaSuccess(context);
                    }
  
                  },
                  child: const Text('Insertar'),
                )
              ],
            ),
          ),
        ));
  }
}