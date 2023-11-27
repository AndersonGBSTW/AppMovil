import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Button.dart';
import 'package:flutter_application_1/listarUsuarios.dart';

class Alertas{

  //Editar
  static Future<bool>editarAlerta(BuildContext context,String titulo,String descripcion) async {
    Completer<bool> completer = Completer();
   AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      titleTextStyle: const TextStyle(color: Colors.black),
      descTextStyle: const TextStyle(color: Colors.black),
      title: titulo,
      desc: descripcion,
      width: 600,
      btnCancelOnPress: () {
        completer.complete(false);
      },
      btnOkOnPress: () {
        completer.complete(true);
        editarAlertaSuccess(context);
         Future.delayed(const Duration(seconds: 2),(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Menu())
            );
          }
        );
      },
    ).show();
    return completer.future;
  }
  static Future<bool>editarAlertaSuccess(BuildContext context) async {
  Completer<bool> completer = Completer();  
   AwesomeDialog(
      context: context,
      width: 350,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Editado',
    ).show();
    return completer.future;
  }


   //Eliminar
  static Future<bool>eliminarAlerta(BuildContext context,String titulo,String descripcion) async {
    Completer<bool> completer = Completer();
   AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      titleTextStyle: const TextStyle(color: Colors.black),
      descTextStyle: const TextStyle(color: Colors.black),
      title: titulo,
      desc: descripcion,
      width: 600,
      btnCancelOnPress: () {
        completer.complete(false);
      },
      btnOkOnPress: () {
        completer.complete(true);
        eliminarAlertaSuccess(context);
         Future.delayed(const Duration(seconds: 2),(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Menu())
            );
          }
        );
      },
    ).show();
    return completer.future;
  }
  static Future<bool>eliminarAlertaSuccess(BuildContext context) async {
  Completer<bool> completer = Completer();  
   AwesomeDialog(
      context: context,
      width: 350,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Eliminado',
    ).show();
    return completer.future;
  }

//Insertar
  static Future<bool>insertarAlerta(BuildContext context,String titulo,String descripcion) async {
    Completer<bool> completer = Completer();
   AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      titleTextStyle: const TextStyle(color: Colors.black),
      descTextStyle: const TextStyle(color: Colors.black),
      title: titulo,
      desc: descripcion,
      width: 600,
      btnCancelOnPress: () {
        completer.complete(false);
      },
      btnOkOnPress: () {
        completer.complete(true);
        editarAlertaSuccess(context);
         Future.delayed(const Duration(seconds: 2),(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ListarUsuarios())
            );
          }
        );
      },
    ).show();
    return completer.future;
  }
  static Future<bool>insertarAlertaSuccess(BuildContext context) async {
  Completer<bool> completer = Completer();  
   AwesomeDialog(
      context: context,
      width: 350,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Usuario Creado',
    ).show();
    return completer.future;
  }



}

