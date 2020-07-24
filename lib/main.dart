import 'package:flutter/material.dart';
import 'package:to_do_banco_dados/rotas.dart';
import 'package:to_do_banco_dados/to_do.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        Rotas.INICIAL: (ctx) => ToDo(),
      },
    );
  }
}
