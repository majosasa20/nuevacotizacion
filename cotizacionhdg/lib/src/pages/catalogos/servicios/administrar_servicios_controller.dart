import 'package:cotizaciones_hdg/src/models/servicios_model.dart';
import 'package:cotizaciones_hdg/src/provider/servicios_provider.dart';
import 'package:flutter/material.dart';
import '../../../models/empresas_model.dart';
import '../../../models/response_api.dart';
import '../../../styles/my_snackbar.dart';
import '../../../styles/shared_pref.dart';

class AdministrarServiciosxEmpresaController{
  BuildContext? context;
  Function? refresh;
  SharedPref _sharedPref = new SharedPref();
  ServiciosProvider serviciosProvider = new ServiciosProvider();
  Empresas? empresas;
  late int id_empresa;// = empresas?.idEmpresa;
  late String? nombre_empresa = '';
  // late int? id_empresa = empresas?.idEmpresa;
  // late String? nombre_empresa = '';
  late List<Servicio?> servicios = [];

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    // if (refresh != null) {
      this.refresh = refresh;
    // } else {
    // }

    await obtenerDatos();
    // empresas = Empresas.fromJson(await _sharedPref.read('empresa') ?? {});
    // nombre_empresa = empresas?.nombreEmpresa;
    // final parametros = ModalRoute
    //     .of(context)!
    //     .settings
    //     .arguments as Map<String, dynamic>;
    // id_empresa = parametros["idEmpresa"];
    // nombre_empresa = parametros["nombreEmpresa"];

    if (id_empresa != null) {
      print('empresa código: $id_empresa');
      ResponseApi? responseApi = await serviciosProvider.getServicioEmpresa(id_empresa!);
      print('Respuesta: ${responseApi?.toJson()}');

      if (responseApi != null && responseApi.success != null) {
        if (responseApi.success!) {
          List<dynamic> servicioDataList = responseApi.data;

          // Convertir la lista de datos JSON en una lista de objetos Servicio
          List<Servicio> listaDeServicios = servicioDataList.map((item) => Servicio.fromJson(item)).toList();

          // Guardar la lista de objetos Servicio en SharedPreferences
          _sharedPref.save('servicios', listaDeServicios.map((servicio) => servicio.toJson()).toList());

          // Puedes asignar la lista de objetos Servicio a tu variable "usuarios" si lo necesitas
          servicios = listaDeServicios;

        } else {
          MySnackbar.show(context!, responseApi.message ?? 'Mensaje de error predeterminado');
        }
      } else {
      }
    } else {
      MySnackbar.show(context!, 'NO SE ENCUENTRAN LOS SERVICIOS');
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

  void goToDetalleServicio(idServicio){
    Navigator.pushNamed(context!, 'verdetalleServicio', arguments: idServicio);
  }
  void crearServicios(){
    Navigator.pushNamed(context!, 'crearServicio');
  }

  void logout(){
    _sharedPref.logout(context!);
  }
}