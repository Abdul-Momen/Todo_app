import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todu_app/todu_model.dart';
import 'package:todu_app/db_serviecs/db_sercices.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoModel> todos = [];

  String description = "";

  final _fromKey = GlobalKey<FormState>();

  late final DbService _dbService;

  getallTodo(){
    _dbService= DbService();
    _dbService.getAllTodoModel().then((value) {
      setState(() {
        todos.addAll(value);

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getallTodo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo app"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                var todo = todos[index];

                return ListTile(
                  title: Text(todo.description),
                  trailing: Switch(
                    value: todo.iscompelete,
                    onChanged: (bool value) {
                      todo.iscompelete = value;
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Form(
                key: _fromKey,
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: TextFormField(
                          onSaved: (value) {
                            description = value!;
                          },
                        )),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() async {
                            _fromKey.currentState!.save();

                            var todu = TodoModel(description: description);

                            await _dbService.saveTodo(todu);

                            description = "";
                            _fromKey.currentState!.reset();
                          });
                        },
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
