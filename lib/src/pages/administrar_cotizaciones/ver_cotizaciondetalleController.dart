import 'package:cotizaciones_hdg/src/models/cotizacion_model.dart';
import 'package:cotizaciones_hdg/src/provider/cotizaciones_provider.dart';
import 'package:cotizaciones_hdg/src/provider/estadoscotizacion_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/empresas_model.dart';
import '../../models/estadosCotizacion_model.dart';
import '../../models/response_api.dart';
import '../../styles/my_snackbar.dart';
import '../../styles/shared_pref.dart';

class VerCotizacionDetalleController {
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  Empresas? empresas;
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = '';
  late List<EstadosCotizacion?> estadocotlist = [];
  EstadosCotizacion? estadoCotizacion;
  late dynamic idCotizacion;
  EstadosCotizacionProvider estadoCotizacionProvider = new EstadosCotizacionProvider();
  CotizacionesProvider cotizacionesProvider = new CotizacionesProvider();
  Cotizacion? cotizaciones;
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:MM');

  TextEditingController servicioController = new TextEditingController();
  TextEditingController clienteController = new TextEditingController();
  TextEditingController correoclienteController = new TextEditingController();
  TextEditingController telefonoclienteController = new TextEditingController();
  TextEditingController destinoController = new TextEditingController();
  TextEditingController caracteristicaController = new TextEditingController();
  TextEditingController fechaServicioController = new TextEditingController();
  TextEditingController fechaSolicitudController = new TextEditingController();
  TextEditingController estadoCotizacionController = new TextEditingController();
  TextEditingController observacionesController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    obtenerDatos();
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    idCotizacion = ModalRoute.of(context!)!.settings.arguments;
    // nombre_empresa = empresas?.nombreEmpresa;
    // print('idusuario: $idUsuario');

    if (idCotizacion != null) {
      // print('caracteristica código: $idCaracteristica');
      ResponseApi? responseApi =
          await cotizacionesProvider.getCotizacionById(idCotizacion);
      print('Respuesta Coti: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          cotizaciones = Cotizacion.fromJson(responseApi.data!);
          print('abajo se muestra la cotizacion: ${cotizaciones?.toJson()}');
          if (cotizaciones != null){
            servicioController.text = cotizaciones!.nombreServicio.toString();
            clienteController.text = cotizaciones!.nombreUsuario.toString();
            correoclienteController.text = cotizaciones!.correoUsuario.toString();
            telefonoclienteController.text = cotizaciones!.telefonoUsuario.toString();
            destinoController.text = cotizaciones!.destino.toString();
            caracteristicaController.text =  '${cotizaciones!.cantidad.toString()}  -   ${cotizaciones!.descripcionCaracteristica.toString()}';
            fechaServicioController.text =  dateFormat.format(cotizaciones?.fechaservicio ?? DateTime.now());
            fechaSolicitudController.text =  dateFormat.format(cotizaciones?.fechacotizacion ?? DateTime.now());
            estadoCotizacionController.text = cotizaciones!.descripcionestado.toString();
            if (cotizaciones!.observaciones.toString() == 'null') {
              observacionesController.text = " ------ ";
            }  else {observacionesController.text = '${cotizaciones!.observaciones.toString() ?? " ------ "}';}
          }
        }
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRA EL USUARIO');
    }

    //LLENAR EL DROPDOWN ESTADOS
    ResponseApi? responseApiestado = await estadoCotizacionProvider.getEstadosCotizacion();
    print('Respuesta estadocotizacion Todas: ${responseApiestado?.toJson()}');
    if (responseApiestado != null && responseApiestado.success != null) {
      if (responseApiestado.success!) {
        List<dynamic> estadocotizacionsdataList = responseApiestado.data;

        if (estadocotizacionsdataList is List) {
          // Convertir la lista de datos JSON en una lista de objetos
          List<EstadosCotizacion> listaDeCotizaciones =
              estadocotizacionsdataList.map((item) {
            if (item is Map<String, dynamic>) {
              return EstadosCotizacion.fromJson(item);
            } else {
              return EstadosCotizacion(); // O algo similar
            }
          }).toList();
          // Guardar la lista de objetos en SharedPreferences
          _sharedPref.save(
              'roles',
              listaDeCotizaciones
                  .map((estadoCotizacion) => estadoCotizacion?.toJson())
                  .toList());
          // Asignar lista de objetos a la variable "empresas2" en caso de ser necesario
          estadocotlist = listaDeCotizaciones;
        }
      } else {
        MySnackbar.show(context!,
            responseApiestado.message ?? 'Mensaje de error predeterminado');
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

  Future<void> guardarCotizacion( idEstadoCotizacion, idCotizacion, idEmpresa, idServicio, idUsuario) async {
    int idEstado = int.parse(idEstadoCotizacion);
    ResponseApi? responseApinew = await cotizacionesProvider.editarCotizacion(idEstado, idCotizacion, idEmpresa, idServicio, idUsuario);
    print('Cambio estado: ${responseApinew?.toJson()}');
    if (responseApinew!.success!) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context!, 'adminCotizaciones');
      });
      MySnackbar.show(context!, responseApinew.message);
    } else {
      MySnackbar.show(context!, "Error al modificar el usuario.");
    }
  }

  void cancelar() {
    Navigator.pushReplacementNamed(context!, 'adminCotizaciones');
  }

  void logout() {
    _sharedPref.logout(context!);
  }
}
