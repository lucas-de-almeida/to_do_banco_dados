import 'package:flutter/cupertino.dart';

class Task {
  String tarefa;
  bool check;
  int id;

  Task.empty();

  Task({
    @required this.id,
    @required this.tarefa,
    @required this.check,
  });

  factory Task.apartirDoMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      tarefa: map['tarefa'],
      check: map['check'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> paraMap() {
    return {
      'id': id,
      'tarefa': tarefa,
      'ativo': check ? 1 : 0,
    };
  }
}
