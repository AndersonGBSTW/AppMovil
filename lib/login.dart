import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Button.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formContacto = GlobalKey<FormState>();
    TextEditingController txtUser = TextEditingController();
    TextEditingController txtRol = TextEditingController();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Barberia y Peluqueria Valhalla",
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 203, 203, 203)),
          ),
          backgroundColor: const Color.fromARGB(255, 29, 39, 56),
          centerTitle: true,
        ),
        body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          SizedBox(
            width: 200.0, 
            height: 200.0,
            child: Image.asset('assets/imagenes/valhalla.png',), 
          ),
          Container(
           padding: const EdgeInsets.all(20.0),
           alignment: Alignment.center,
           child:FractionallySizedBox(
           widthFactor: 0.7,
           child:Form(
          key:formContacto,
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login',style: TextStyle(fontSize: 20)),
              const SizedBox(height: 30,),
              const Center(
                child: ListTile(
                  title: Center(child: Text('usuarios')),
                ),
              ),
              TextFormField(
                controller: txtUser,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText:'Ingrese usuario',
                ),
                 validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo es requerido';
                            }
                            return null;
                          },
              ),
              const ListTile(
                title: Center(child: Text('Rol')),
              ),
              TextFormField(
                controller: txtRol,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su Rol',
                ),
                 validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo es requerido';
                            }
                            return null;
                          },
              ),
              const SizedBox(height: 16),
              Builder(
                  builder: (BuildContext builderContext) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (!formContacto.currentState!.validate()) {
                          return;
                        }
                        String usuario = txtUser.text;
                        String rol = txtRol.text;
          
                        bool valido= await validarDatos(usuario,rol);
                        
                              if (valido){
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                  builderContext,
                                  MaterialPageRoute(builder: (BuildContext context) => const Menu()
                                  ),
                                );
                              }else{
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(builderContext).showSnackBar(
                                const SnackBar(content: Text('Credenciales incorrectas')),
                                );
                              }
                            },
                            child: const Text('Ingresar'),
                              );
                            },
                          )
                      ],
                    ),
                  )
                )
              )
          ]  
        )
      )
    );
  }
}

Future<bool> validarDatos(String usuario,String rol) async{
  final response = await http.get(Uri.parse('https://backend-valhalla.onrender.com/ruta/usuarios'));
  var valor=false;

  if(response.statusCode==200){
    Map<String,dynamic> decodedData =json.decode(response.body);

    var data=decodedData['usuarios']??[];

    for (var element in data) {
      if(element['nombres']==usuario && element['rol']==rol){
        print('Es un usuario Valido');
         valor=true;
      }
    }
    return valor;
  }else{
    print('No existe ese usuario');
    return false;
  }
}

