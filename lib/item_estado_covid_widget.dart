import 'package:app_covid/estado_covid.dart';
import 'package:app_covid/estado_detalhe_page.dart';
import 'package:flutter/material.dart';

class ItemEstadoCovidWidget extends StatelessWidget {
  final EstadoCovid estadoCovid;

  const ItemEstadoCovidWidget({
    Key key,
    this.estadoCovid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(estadoCovid.state),
      subtitle: Text(
        'Casos: ${estadoCovid.cases} | Mortes: ${estadoCovid.deaths}',
      ),
      leading: Text(estadoCovid.uf),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EstadoDetalhePage(
              estadoCovid: estadoCovid,
            ),
          )),
    );
  }
}
