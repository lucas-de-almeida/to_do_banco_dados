import 'package:to_do_banco_dados/banco_dados.dart';
import 'package:to_do_banco_dados/mock_user.dart';

class TarefaRepositorio {
  final BancoDeDados _bancoDeDados;
  TarefaRepositorio(this._bancoDeDados);

  Future<bool> salvaTarefa(Task task) async {
    try {
      var instanciaDB = await _bancoDeDados.recuperarInstancia();
      var resultado = await instanciaDB.insert('tarefas', task.paraMap());
    } catch (e) {
      return false;
    }
  }

  Future<bool> atualizaTarefa(Task task) async {
    try {
      var instanciaDB = await _bancoDeDados.recuperarInstancia();

      var resultado = await instanciaDB.update('tarefas', task.paraMap(),
          where: 'id = ?', whereArgs: [task.id]);
      return resultado > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> excluirTarefa(int id) async {
    try {
      var instanciaDB = await _bancoDeDados.recuperarInstancia();
      var resultado =
          await instanciaDB.delete('tarefas', where: 'id = ?', whereArgs: [id]);

      return resultado > 0;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Task>> recuperarTarefas() async {
    try {
      await Future.delayed(Duration(seconds: 3));

      // throw '';

      var instanciaDB = await _bancoDeDados.recuperarInstancia();

      final resultado = await instanciaDB.query('tarefas');

      var tarefas = resultado.map((e) => Task.apartirDoMap(e))?.toList();

      return tarefas ?? [];
    } catch (e) {
      throw 'Erro ao buscar as tarefas';
      print(e);
    }
  }
}
