import 'package:flutter/material.dart';
import 'package:to_do_banco_dados/banco_dados.dart';
import 'package:to_do_banco_dados/list_task.dart';
import 'package:to_do_banco_dados/mock_user.dart';
import 'package:to_do_banco_dados/tarefa_repositorio.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  // var _listTask = <Task>[
  //   Task('Tarefa1', true),
  //   Task('Tarefa2', false),
  // ];
  Task task;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tarefa.dispose();
    super.dispose();
  }

  final _form = GlobalKey<FormState>();
  var _tarefa = TextEditingController();

  TarefaRepositorio repositorio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repositorio = TarefaRepositorio(BancoDeDados());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder<List<Task>>(
          future: repositorio.recuperarTarefas(),
          initialData: null,
          builder: (ctx, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData && snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }
            return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _form,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                labelStyle: TextStyle(color: Colors.blue),
                              ),
                              controller: _tarefa,
                              validator: (value) {
                                if ((value.length ?? 0) < 1) {
                                  return 'Insira uma atividade';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            child: Text('Adicionar'),
                            color: Colors.white,
                            onPressed: () {
                              if (_form.currentState.validate()) {
                                setState(() {
                                  task.check = false;
                                  task.tarefa = _tarefa.text;
                                  repositorio.salvaTarefa(task);
                                });
                                _tarefa.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: Checkbox(
                                value: snapshot.data[index].check,
                                onChanged: (value) {
                                  setState(() {
                                    snapshot.data[index].check;
                                  });
                                }),
                            title: Text(snapshot.data[index].tarefa),
                            onLongPress: () {
                              repositorio
                                  .excluirTarefa(snapshot.data[index].id);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
