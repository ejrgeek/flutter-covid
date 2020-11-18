import 'package:app_covid/database_helper.dart';
import 'package:app_covid/estado_covid.dart';
import 'package:app_covid/item_estado_covid_widget.dart';
import 'package:flutter/material.dart';

class ListEstadoCovidPage extends StatefulWidget {
  @override
  _ListEstadoCovidPageState createState() => _ListEstadoCovidPageState();
}

class _ListEstadoCovidPageState extends State<ListEstadoCovidPage> {
  var _db = DatabaseHelper();
  List<EstadoCovid> _listEstados = List<EstadoCovid>();

  getEstados() async {
    List estados = await _db.getAll();

    List<EstadoCovid> listTemp = List<EstadoCovid>();
    for (var item in estados) {
      EstadoCovid est = EstadoCovid.fromJson(item);
      listTemp.add(est);
    }

    setState(() {
      _listEstados = listTemp;
    });

    listTemp = null;
  }

  filterDeaths() async {
    List estados = await _db.orderByDeath();

    List<EstadoCovid> listTemp = List<EstadoCovid>();
    for (var item in estados) {
      EstadoCovid est = EstadoCovid.fromJson(item);
      listTemp.add(est);
    }

    setState(() {
      _listEstados = listTemp;
    });

    listTemp = null;
  }

  filterCases() async {
    List estados = await _db.orderByCases();

    List<EstadoCovid> listTemp = List<EstadoCovid>();
    for (var item in estados) {
      EstadoCovid est = EstadoCovid.fromJson(item);
      listTemp.add(est);
    }

    setState(() {
      _listEstados = listTemp;
    });

    listTemp = null;
  }

  @override
  void initState() {
    super.initState();
    getEstados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de estados'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Filtros',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //
                      RaisedButton(
                        child: Text('Por mortes'),
                        onPressed: () => filterDeaths(),
                      ),
                      //
                      RaisedButton(
                        child: Text('Por casos'),
                        onPressed: () => filterCases(),
                      ),
                      //

                      RaisedButton(
                        child: Text('Limpar'),
                        onPressed: () => getEstados(),
                      ),
                      //
                      //
                    ],
                  ),
                )
              ],
            ),
          ),
          //
          Expanded(
            flex: 80,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _listEstados.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ItemEstadoCovidWidget(
                  estadoCovid: _listEstados[index],
                );
              },
            ),
          ),
          //
        ],
      ),
    );
  }
}
