import 'package:cotizaciones_hdg/src/models/cotizacion_model.dart';
import 'package:cotizaciones_hdg/src/provider/cotizaciones_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/response_api.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';

class VerCotizacionClienteController {
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  late dynamic idCotizacion;
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
  TextEditingController empresaController = new TextEditingController();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    idCotizacion = ModalRoute.of(context!)!.settings.arguments;

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
            empresaController.text = cotizaciones!.nombre_empresa.toString();
            if (cotizaciones!.observaciones.toString() == 'null') {
              observacionesController.text = " ------ ";
            }  else {observacionesController.text = '${cotizaciones!.observaciones.toString() ?? " ------ "}';}
          }
        }
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRA LA EMPRESA');
    }
    refresh();
  }

  void cancelar() {
    Navigator.pushReplacementNamed(context!, 'cotizacionesClientes');
  }

  void logout() {
    _sharedPref.logout(context!);
  }
}
