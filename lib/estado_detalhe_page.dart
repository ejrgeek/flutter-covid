import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'estado_covid.dart';

class EstadoDetalhePage extends StatelessWidget {
  final EstadoCovid estadoCovid;

  const EstadoDetalhePage({
    Key key,
    this.estadoCovid,
  }) : super(key: key);

  dateFormat(String timestamp) {
    initializeDateFormatting();
    DateTime date = DateTime.parse(timestamp);
    return DateFormat("dd/MM/yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(estadoCovid.state),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Unidade federativa: ${estadoCovid.uf}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Nome: ${estadoCovid.state}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Numero de casos: ${estadoCovid.cases}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Numero de mortes: ${estadoCovid.deaths}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Casos suspeitos: ${estadoCovid.suspects}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Casos descartados: ${estadoCovid.refuses}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Data: ${dateFormat(estadoCovid.datetime)}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
