import 'package:cotizaciones_hdg/src/models/caracteristicas_model.dart';
import 'package:cotizaciones_hdg/src/models/servicios_model.dart';
import 'package:cotizaciones_hdg/src/provider/caracteristicas_provider.dart';
import 'package:cotizaciones_hdg/src/provider/servicios_provider.dart';
import 'package:flutter/material.dart';

import '../../../models/empresas_model.dart';
import '../../../models/response_api.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';

class VerDetalleServicioController {
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
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

  TextEditingController nombreservicioController = new TextEditingController();
  TextEditingController descricionController = new TextEditingController();
  TextEditingController salidaUbicacionController = new TextEditingController();
  TextEditingController imagenEncabezadoController = new TextEditingController();
  TextEditingController duracionController = new TextEditingController();
  TextEditingController empresaController = new TextEditingController();
  TextEditingController caracteristicaController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    await obtenerDatos();
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    idServicio = ModalRoute.of(context!)!.settings.arguments;
    // nombre_empresa = empresas?.nombreEmpresa;
    // print('nombreEmpresa: $nombre_empresa');

    if (idServicio != null) {
      // print('caracteristica código: $idCaracteristica');
      ResponseApi? responseApi =
      await serviciosProvider.getServicioById(idServicio);
      print('Respuesta Servicios: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          servicios = Servicio.fromJson(responseApi.data!);
          print('abajo se muestra el servicio: ${servicios?.toJson()}');
          if (servicios != null){
            nombreservicioController.text =  servicios!.nombre.toString();
            descricionController.text = servicios!.descripcion.toString();
            salidaUbicacionController.text = servicios!.salida_ubicacion.toString();
            imagenEncabezadoController.text = servicios!.imagenencabezado.toString();
            duracionController.text = servicios!.duracion.toString();
            empresaController.text = servicios!.nombre_empresa.toString();
            precioController.text = servicios!.precio.toString();
            if (servicios!.caracteristicas.isNotEmpty) {
              String? primerNombreCaracteristica = servicios!.caracteristicas[0].descripcion;
              caracteristicaController.text = primerNombreCaracteristica!;
            }
          }
        }
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRA EL SERVICIO');
    }

    //LLENAR EL DROPDOWN ESTADOS
    ResponseApi? responseApicaracteristica = await caracteristicasProvider.getCaracteristicasEmpresa(id_empresa!);
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
    String? imagen = imagenEncabezadoController.text.trim();

    ResponseApi? responseApinew = await serviciosProvider.editarServicio(idServicio, id_empresa!, nombreServicio, descripcion, salidaUbicacion, precio, duracion,imagen, idcaracteristica);
    print('Cambio Servicio: ${responseApinew?.toJson()}');
    if (responseApinew!.success!) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa');
      });
      MySnackbar.show(context!, responseApinew.message);
    } else {
      MySnackbar.show(context!, "Error al modificar el servicio.");
    }
  }

  Future<void> eliminarServicio(idServicio, idempresa) async {
    this.refresh = refresh;
    ResponseApi? responseApi = await serviciosProvider.eliminarServicio(idServicio, idempresa);
    MySnackbar.show(context!, responseApi?.message);
    if (responseApi!.success!){
      Future.delayed(Duration(seconds: 2), () {
        MySnackbar.show(context!, "Servicio Eliminado");
        Map<String, dynamic> parametros = {
          "idEmpresa": id_empresa,
          "nombreEmpresa": nombre_empresa,
        };
        Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa', arguments: parametros);
      });
    }else {
      MySnackbar.show(context!, 'Error al eliminar Servicio ${responseApi?.message}');
      Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa');
    }
  }

  void cancelar() {
    Navigator.pushReplacementNamed(context!, 'adminserviciosxempresa');
  }

  void logout() {
    _sharedPref.logout(context!);
  }
}