import 'estado_covid.dart';

abstract class EstodoCovidDAO {
  insertAll(List<EstadoCovid> estados);
  updateDB(List<EstadoCovid> estados);
  getAll();
  orderByCases();
  orderByDeath();
}
