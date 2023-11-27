
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Alert.dart';
import 'package:flutter_application_1/editarUsuarios.dart';
import 'package:flutter_application_1/eliminarUsuarios.dart';
import 'package:http/http.dart' as http;

class ListarUsuarios extends StatefulWidget {  
  const ListarUsuarios({super.key});
  @override
  State<ListarUsuarios> createState() => _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  List<dynamic>data=[];
  List<dynamic> originalData = [];

  @override
  void initState(){
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios()async{
    final response =await http.get(Uri.parse('https://backend-valhalla.onrender.com/ruta/usuarios'));

    if(response.statusCode==200){
      Map<String,dynamic>decodedData =json.decode(response.body);
      setState(() {
        data=decodedData['usuarios']??[];
        originalData = List.from(data);
      });
    }else{
      print('Failed to load data. Status Code: ${response.statusCode}');
    }
  }

    void realizarBusqueda(String query) {
     setState(() {
      // Filtramos la lista original en tiempo real
      data = originalData.where((item) => item['nombres'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
          title: const Center(child: Text('Lista de usuarios')),
      ),
      body:Column(
        children: [
          TextField(
            style: const TextStyle(color: Color.fromARGB(255, 109, 98, 98)),
            onChanged: (query) {
              realizarBusqueda(query);
            },
            decoration: const InputDecoration( 
              hintText: 'Buscar por nombres...',
              
              icon: Icon(Icons.search),              
            ),
          ),
          const SizedBox(height: 10,),
            Expanded(
            child:ListView.builder( 
            itemCount: data.length,
            itemBuilder:(BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                        title:Text("ID: ${data[index]['_id'].toString()}"),
                      ),
                    ListTile(
                        title:Text("Nombre: ${data[index]['nombres'].toString()}"),
                    ),
                     ListTile(
                        title:Text("Apellidos: ${data[index]['apellidos'].toString()}"),
                    ),
                     ListTile(
                        title:Text("Username: ${data[index]['username'].toString()}"),
                    ),
                     ListTile(
                        title:Text("Rol: ${data[index]['rol'].toString()}"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                          Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {  
                                Navigator.push(context, MaterialPageRoute(builder: ((context) =>
                                   EditarUsuarios(id:data[index]['_id'].toString(),nombres2:data[index]['nombres'].toString(),rol2:data[index]['rol'].toString())
                                   ),
                                ));
                              },
                              child: const Text('Editar'),
                            ),
                          ],
                        ),
                        ),
                        Expanded(
                          child: 
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed:() async{
                                     bool confirmacion = await Alertas.eliminarAlerta(context,"Eliminar Usuario","Estas seguro de eliminar el usuario?");
                                    if(confirmacion){
                                      EliminarUsuarios eliminar = EliminarUsuarios(id:data[index]['_id'].toString());
                                      // ignore: use_build_context_synchronously
                                      await eliminar.eliminarUsuarios(context);
                                      // ignore: use_build_context_synchronously
                                    }
                                },
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              );
            }
          ),
          )
       ],
      )
     );
  }
}

class SearchUsuariosDelegate extends SearchDelegate<ListarUsuarios> {

  final List<dynamic> data;

  SearchUsuariosDelegate(this.data);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]['nombres'].toString()),
          onTap: () {
            // Implementa la lógica al hacer clic en un resultado
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]['nombres'].toString()),
          onTap: () {
          },
        );
      },
    );
  }
}