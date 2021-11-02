import 'package:hive/hive.dart';
import 'package:todu_app/todu_model.dart';

class DbService{

  final _todokey = "todos";
  final _todoBoxkey = "todoBox";

  //read All from databasd ;
  Future<List<TodoModel>> getAllTodoModel()async{
    var box = await Hive.openBox(_todoBoxkey);
    List<TodoModel> todos=[];
    var todoJson = box.get(_todokey);
    if(todoJson != null){
      var list = TodoModel.todoLitsFromJson(todoJson);
      todos.addAll(list);
    }
    return todos;
  }


  //save all data in database ;
  Future<void> saveTodo(TodoModel todoModel)async{
    var box = await Hive.openBox(_todoBoxkey);
    var todos=await getAllTodoModel();

    todos.add(todoModel);
    box.put(_todokey, TodoModel.todolistTojson(todos));

  }
}