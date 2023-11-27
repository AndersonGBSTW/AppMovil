import 'package:flutter/material.dart';
import 'package:flutter_application_1/insertarUsuarios.dart';
import 'package:flutter_application_1/listarUsuarios.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/temas/apptheme/apptheme.dart';

void main() {
  runApp(const Menu());
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MainAppState();
}

class _MainAppState extends State<Menu> {
   ThemeData currentTheme = AppBarTheme1.theme2;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:currentTheme,
      home: Scaffold(
        appBar: AppBar(    
          title: const Text(
            "Gimnasio Valhalla",
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 203, 203, 203)), 
          ),
          actions: [
            TextButton(
              onPressed: (){
              setState(() {
                  currentTheme =
                      (currentTheme == AppBarTheme1.theme1) ? AppBarTheme1.theme2 : AppBarTheme1.theme1;
                });
              },
              child: const Icon(Icons.color_lens),
            )
          ],
          backgroundColor: const Color.fromARGB(255, 29, 39, 56),
          centerTitle: true,
        ),
        body: [const ListarUsuarios(), const InsertarUsuarios(),const MainApp()][index],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Listar"),
            NavigationDestination(
                icon: Icon(Icons.room_service), label: "Crear"),
            NavigationDestination(
                icon: Icon(Icons.exit_to_app), label: "Salir"),
          ],
          selectedIndex: index,
          onDestinationSelected: (int index2) {
            if (index == index2){
                 return;
            }if(index2 ==2){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainApp()));
            }else{
              setState(() {
            index = index2;
            });
            }  
            },
           )
           )
          );
          }
}