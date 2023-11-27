// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Alert.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditarUsuarios extends StatelessWidget {

  String? id;
  String? nombres2;
  String? rol2;

  EditarUsuarios({super.key,this.id, this.nombres2,this.rol2});
  TextEditingController nombres = TextEditingController();
  TextEditingController rol = TextEditingController();

Future<void> editarUsuarios() async {
  const String url = 'https://backend-valhalla.onrender.com/ruta/usuarios';
  final Map<String, dynamic> data = {
    '_id':id,
    'nombres': nombres.text, 
  'rol': rol.text
  };
  
  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    print('Response: $response');

    print('Solicitud: ${json.encode(data)}');

    if (response.statusCode == 200) {
      print('Put creado con éxito');
    } else {
      print('Error al crear el put. Código de estado: ${response.statusCode} Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error durante la solicitud HTTP: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formEditar = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Editar Usuario",
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 203, 203, 203)),
          ),
          backgroundColor: const Color.fromARGB(255, 29, 39, 56),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formEditar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
                  controller: nombres,
                  decoration:  InputDecoration(
                    labelText: nombres2,
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
                  decoration:  InputDecoration(
                    labelText: rol2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async{
                    if (!formEditar.currentState!.validate()) {
                          return;
                        }

                    bool confirmacion= await Alertas.editarAlerta(context,"Editar Usuario","Estas seguro de editar el usuario?");

                    if(confirmacion){
                      editarUsuarios();
                      // ignore: use_build_context_synchronously
                      Alertas.editarAlertaSuccess(context);
                    }
                  },
                  child: const Text('Editar'),
                )
              ],
            ),
          ),
        ));
  }
}