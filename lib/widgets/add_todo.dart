import 'package:flutter/material.dart';
import 'package:flutter_fire_base/data/listTodo.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key, required this.onAddToDo});
  //Добавили функцию обратного вызова. Она приходит в виджет через конструктор
  final Function(String) onAddToDo;

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String? _userToDo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить элемент'),
      content: TextField(
        onChanged: (String value) {
          setState(() {
            _userToDo = value;
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              // Добавляем в список новую запись
              // listTodo.add(_userToDo!);
              //Теперь новую запись добавляем не сразу в список, а в функцию обратного вызова.
              widget.onAddToDo(_userToDo!);
            });
            Navigator.of(context).pop(); // При нажатии кнопки, нужно закрыть все всплывающие окна
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}