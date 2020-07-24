import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BancoDeDados {
  Database _instancia;

  static final BancoDeDados _bancoDeDados = BancoDeDados._interno();

  factory BancoDeDados() {
    return _bancoDeDados;
  }

  BancoDeDados._interno();

  Future<Database> recuperarInstancia() async {
    if (_instancia == null) {
      _instancia = await _abrirBancodeDados();
    }
  }

  Future<Database> _abrirBancodeDados() async {
    final caminhoBancoDeDados = await getDatabasesPath();
    final banco = await openDatabase(
      join(caminhoBancoDeDados, 'lista_tarefas.db'),
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE tarefas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tarefa TEXT,
        check INTEGER
      )
      ''');
      },
      version: 1,
    );
    return banco;
  }
}
