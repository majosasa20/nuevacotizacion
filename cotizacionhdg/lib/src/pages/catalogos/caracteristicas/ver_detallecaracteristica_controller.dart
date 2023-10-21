import 'dart:ffi';

import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:cotizaciones_hdg/src/models/medida_model.dart';
import 'package:cotizaciones_hdg/src/provider/caracteristicas_provider.dart';
import 'package:flutter/material.dart';

import '../../../models/empresas_model.dart';
import '../../../models/response_api.dart';
import '../../../provider/medidas_provider.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';

 class VerDetalleCaracteristicaController{
   BuildContext? context;
   Function? refresh;
   SharedPref _sharedPref = new SharedPref();
   dynamic idCaracteristica;
   Empresas? empresas;
   // late int? id_empresa = empresas?.idEmpresa;
   // late String? nombre_empresa = empresas?.nombreEmpresa;
   late int id_empresa;// = empresas?.idEmpresa;
   late String? nombre_empresa = '';
   Medida? medida;
   late List<Medida?> medidas = [];
   MedidasProvider medidasProvider = new MedidasProvider();
   CaracteristicasProvider caracteristicasProvider = new CaracteristicasProvider();
   Caracteristicas? caracteristicas;

   TextEditingController descripcionController = new TextEditingController();
   TextEditingController empresaController = new TextEditingController();
   TextEditingController precioController = new TextEditingController();
   TextEditingController medidaController = new TextEditingController();

   Future? init(BuildContext context, Function refresh) async {
     this.context = context;
     this.refresh = refresh;
     obtenerDatos();
     // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
     if (idCaracteristica == null) {
       idCaracteristica = ModalRoute.of(context)!.settings.arguments;
     }
     // final parametros = ModalRoute
     //     .of(context)!
     //     .settings
     //     .arguments as Map<String, dynamic>;
     // id_empresa = parametros["idEmpresa"];
     // nombre_empresa = parametros["nombreEmpresa"];
     // idCaracteristica = parametros["idCaracteristica"];

     if (idCaracteristica != null) {
       // print('caracteristica código: $idCaracteristica');
       ResponseApi? responseApi = await caracteristicasProvider.getCaracteristicaById( idCaracteristica);
       print('Respuesta: ${responseApi?.toJson()}');

       if (responseApi != null && responseApi.success != null) {
         if (responseApi.success!) {
           caracteristicas = Caracteristicas.fromJson(responseApi.data!);
           _sharedPref.save('caracteristicas: ', caracteristicas?.toJson());
           print('abajo se muestra la caracteristica: ${caracteristicas?.toJson()}');
           // print('EMPRESA USUARIO: ${empresas.toJson()}');
           if (caracteristicas?.medidas.isNotEmpty == true) {
             // print (caracteristicas?.medidas);
             print('medida: ${caracteristicas?.medidas[0]}');
             medida = caracteristicas?.medidas[0];
             print(medida);
           } else { }

         } else {
           MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
         }
       } else {
         // Manejar el caso en el que responseApi o responseApi.success son nulos
       }
     }
     else {
       MySnackbar.show(context!, 'NO SE ENCUENTRA LA CARACTERÍSTICA');
     }

     descripcionController.text = caracteristicas!.descripcion.toString();
     empresaController.text = nombre_empresa ?? '';
     precioController.text = caracteristicas!.precio.toString();
     medidaController.text = '${medida?.descripcionMedida.toString() ?? " - "}';

     ResponseApi? responseApimed = await medidasProvider.getMedidas();
     print('Respuesta Medidas Todas: ${responseApimed?.toJson()}');
     if (responseApimed != null && responseApimed.success != null) {
       if (responseApimed.success!) {
         List<dynamic> medidasDataList = responseApimed.data;

         if (medidasDataList is List) {
           // Convertir la lista de datos JSON en una lista de objetos
           List<Medida> listaDeMedidas = medidasDataList.map((item) {
             if (item is Map<String, dynamic>) {
               return Medida.fromJson(item);
             } else {
               return Medida(); // O algo similar
             }
           }).toList();
           // Guardar la lista de objetos en SharedPreferences
           _sharedPref.save('medidas', listaDeMedidas.map((medida) => medida?.toJson()).toList());
           // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
           medidas = listaDeMedidas;
         } else {
         }
       } else {
         MySnackbar.show(context!, responseApimed.message ?? 'Mensaje de error predeterminado');
       }
     }
     refresh();
   }

   Future<void> obtenerDatos() async {
     final nombreEmpresaValue = await _sharedPref.read('nombreEmpresa');
     final idEmpresaValue = await _sharedPref.read('idEmpresa');

     if (nombreEmpresaValue != null) {
       nombre_empresa = nombreEmpresaValue.toString();
       print('Nombre de la empresa catalogos $nombre_empresa');
     }

     if (idEmpresaValue != null) {
       id_empresa = int.parse(idEmpresaValue.toString());
       print('ID de la empresa catalogos $id_empresa');
     }
   }

   Future<void> guardarCaracteristica(idMedida) async {
     String? descripcion = descripcionController.text.trim();
     String? empresa = empresaController.text;
     String? precio = precioController.text.trim();

     if (descripcion.isEmpty || empresa.isEmpty || precio.isEmpty || idMedida == null) {
       MySnackbar.show(context!, 'Debes ingresar todos los campos');
       return;
     } else {
       int? id_medida = int.tryParse(idMedida);
       if (id_medida != null) {
         double? preciofinal = double.tryParse(precio);
         ResponseApi? responseApinew = await caracteristicasProvider.editarCaracteristica(idCaracteristica, descripcion, id_empresa!, preciofinal, id_medida);
         MySnackbar.show(context!, responseApinew?.message);

         if (responseApinew!.success!) {
           Future.delayed(Duration(seconds: 3), () {
             Map<String, dynamic> parametros = {
               "idEmpresa": id_empresa,
               "nombreEmpresa": nombre_empresa,
             };
             Navigator.pushReplacementNamed(context!, 'adminCaracteristicas', arguments: parametros);
           });
         } else {
           MySnackbar.show(context!, "Error al crear la característica.");
         }
       }
     }
   }

   Future<void> eliminarCaracteristica(id_caracteristica, id_empresa) async {
     this.refresh = refresh;
     ResponseApi? responseApi = await caracteristicasProvider.eliminarCaracteristica(id_caracteristica, id_empresa);
     MySnackbar.show(context!, responseApi?.message);
     if (responseApi!.success!){
       Future.delayed(Duration(seconds: 2), () {
         MySnackbar.show(context!, "Caracteristica Eliminada");
         Map<String, dynamic> parametros = {
           "idEmpresa": id_empresa,
           "nombreEmpresa": nombre_empresa,
         };
         Navigator.pushReplacementNamed(context!, 'adminCaracteristicas', arguments: parametros);
       });
     }else {
       MySnackbar.show(context!, "Error al eliminar Caracteristica ");
     }
   }

   void cancelar(){
     // Map<String, dynamic> parametros = {
     //   "idEmpresa": id_empresa,
     //   "nombreEmpresa": nombre_empresa,
     // };
     Navigator.pushReplacementNamed(context!, 'adminCaracteristicas');
   }

   void logout(){
     _sharedPref.logout(context!);
   }
 }