import 'dart:convert';
import 'package:app_covid/database_helper.dart';
import 'package:app_covid/estado_covid.dart';
import 'package:http/http.dart' as http;

class CovidApi {
  String _baseUrl = 'https://covid19-brazil-api.now.sh/api/report/v1';

  Future<bool> getCases() async {
    bool status = false;
    try {
      final http.Response response = await http.get(_baseUrl);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        List<EstadoCovid> estados = List<EstadoCovid>();

        jsonResponse['data'].forEach(
          (endereco) => estados.add(EstadoCovid.fromJson(endereco)),
        );

        List listaDB = await DatabaseHelper().getAll();

        if (listaDB.length == 0) {
          status = await DatabaseHelper().insertAll(estados);
        } else {
          status = await DatabaseHelper().updateDB(estados);
        }

        
        
        print("STATUS: $status");
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return status;
  }
}
