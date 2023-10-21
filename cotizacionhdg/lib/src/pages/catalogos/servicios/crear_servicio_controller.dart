import 'dart:convert';
import 'dart:io';
import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:cotizaciones_hdg/src/models/servicios_model.dart';
import 'package:cotizaciones_hdg/src/provider/caracteristicas_provider.dart';
import 'package:cotizaciones_hdg/src/provider/servicios_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/response_api.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';

class CrearServicioController {
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  // Empresas? empresas;
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = '';
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';
  late List<Caracteristicas?> caracteristicastlist = [];
  Caracteristicas? caracteristicas;
  late dynamic idServicio;
  CaracteristicasProvider caracteristicasProvider = new CaracteristicasProvider();
  ServiciosProvider serviciosProvider = new ServiciosProvider();
  Servicio? servicios;

  PickedFile? pickedFile;
  XFile? xFile;
  File? imageFile;


  TextEditingController nombreservicioController = new TextEditingController();
  TextEditingController descricionController = new TextEditingController();
  TextEditingController salidaUbicacionController = new TextEditingController();
  TextEditingController imagenEncabezadoController = new TextEditingController();
  TextEditingController duracionController = new TextEditingController();
  TextEditingController empresaController = new TextEditingController();
  TextEditingController nombrearchivoController = new TextEditingController();
  // TextEditingController caracteristicaController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
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
    // await obtenerDatos();
    idServicio = ModalRoute.of(context!)!.settings.arguments;
    empresaController.text = nombre_empresa!;

    //LLENAR EL DROPDOWN ESTADOS
    ResponseApi? responseApicaracteristica = await caracteristicasProvider.getCaracteristicasEmpresa(id_empresa);
    print('Respuesta caracteristicas: ${responseApicaracteristica?.toJson()}');
    if (responseApicaracteristica != null && responseApicaracteristica.success != null) {
      if (responseApicaracteristica.success!) {
        List<dynamic> caracteristicasdataList = responseApicaracteristica.data;

        if (caracteristicasdataList is List) {
          // Convertir la lista de datos JSON en una lista de objetos
          List<Caracteristicas> listaDeCaracteristicas =  caracteristicasdataList.map((item) {
            if (item is Map<String, dynamic>) {
              return Caracteristicas.fromJson(item);
            } else {
              return Caracteristicas(medidas: []); // O algo similar
            }
          }).toList();
          // Guardar la lista de objetos en SharedPreferences
          _sharedPref.save('caracteristicas',
              listaDeCaracteristicas
                  .map((estadoCotizacion) => estadoCotizacion?.toJson())
                  .toList());
          // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
          caracteristicastlist = listaDeCaracteristicas;
        }
      } else {
        MySnackbar.show(context!,
            responseApicaracteristica.message ?? 'Mensaje de error predeterminado');
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

  Future<void> guardarServicio(idcaracteristica) async {
    // int idEstado = int.parse(idEstadoCotizacion);
    String? nombreServicio = nombreservicioController.text.trim();
    String? descripcion = descricionController.text.trim();
    String? salidaUbicacion = salidaUbicacionController.text.trim();
    double precio = double.parse(precioController.text);
    double duracion =double.parse(duracionController.text);
    // String? imagen = imagenEncabezadoController.text.trim();
    String? nombreArchivo = nombrearchivoController.text.trim();

    if (nombreServicio.isEmpty ||descripcion.isEmpty || salidaUbicacion.isEmpty || precio <0 || duracion <=0 || nombreArchivo.isEmpty){
      MySnackbar.show(context!, "Llene todos los datos del servicio.");
    }else{
      if (imageFile ==null){
        MySnackbar.show(context!, "Seleciona una imagen");
        return;
      }
      Stream stream = await serviciosProvider.crearWithImage(id_empresa, nombreServicio, descripcion, salidaUbicacion, precio, duracion,nombreArchivo, idcaracteristica, imageFile!);
      stream.listen((res) {
        // ResponseApi? responseApinew = await serviciosProvider.crearWithImage(id_empresa!, nombreServicio, descripcion, salidaUbicacion, precio, duracion,nombreArchivo, idcaracteristica, imageFile!);
        ResponseApi? responseApinew = ResponseApi.fromJson(json.decode(res));
        print('Crear Servicio: ${responseApinew?.toJson()}');
        if (responseApinew!.success!) {
          MySnackbar.show(context!, responseApinew.message);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa');
          });

        } else {
          MySnackbar.show(context!, "Error al crear el servicio.");
        }
      });
      // // ResponseApi? responseApinew = await serviciosProvider.crearWithImage(id_empresa!, nombreServicio, descripcion, salidaUbicacion, precio, duracion,nombreArchivo, idcaracteristica, imageFile!);
      // // ResponseApi? responseApinew = await serviciosProvider.CrearServicio(id_empresa!, nombreServicio, descripcion, salidaUbicacion, precio, duracion,imagen, idcaracteristica);
      // print('Crear Servicio: ${responseApinew?.toJson()}');
      // if (responseApinew!.success!) {
      //   MySnackbar.show(context!, responseApinew.message);
      //   Future.delayed(Duration(seconds: 3), () {
      //     Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa');
      //   });
      //
      // } else {
      //   MySnackbar.show(context!, "Error al crear el servicio.");
      // }
    }
  }

  Future selectImage(ImageSource imageSource) async {
    xFile = await ImagePicker().pickImage(source: imageSource);
    pickedFile = xFile != null ? PickedFile(xFile!.path) : null;

    // pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null){
      imageFile = File(pickedFile!.path);
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog(){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERÍA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton
      ],
    );

    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  void cancelar() {
    Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa');
  }

  void logout() {
    _sharedPref.logout(context!);
  }
}