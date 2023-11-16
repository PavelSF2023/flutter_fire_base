import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_fire_base/data/listTodo.dart';
import 'package:flutter_fire_base/widgets/add_todo.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  //Метод-слушатель, который на вход получает строковое значение и добавляет
  // его в Список. Так как функция добавление в Список обёрнута в SetState(),
  // то при изменении Списка виджет App перерисуется.
  void _handledAddTodo(String todo){
    setState(() {
      listTodo.add(todo);
    });
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Список дел'),
        centerTitle: true,
      ),
      body: ListView.builder(
        //Указываем как будет построен весь наш список
        itemCount: listTodo.length,
        //длину списка можно задать цифрой, а можно привязаться к длине списка
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            //возврат каждого отдельного элемента. Можно через Text() и будет выводится каждый элемент
            key: Key(listTodo[index]),
            //но мы будем делать выборку через изъятие с удалением из списка элемента по индексу
            child: Card(
              //на каждый элемент списка выводим карточку, в которой может быть в содержании картинка, заголовок и т.д.
              child: ListTile(
                //это будет заголовок карточки. А через ListBody описание содержимого
                title: Text(listTodo[index]),
                //Заголовок согласно элемента списка
                trailing: IconButton(
                  //добавляем иконку-кнопку удаления
                  icon: const Icon(
                    //выбираем изображения иконки
                    Icons.delete_sweep, //изображение
                    color: Colors.red, //цвет иконки
                  ),
                  onPressed: () {
                    //Слушатель этой кнопки
                    setState(() {
                      //Отрисовка Состояния
                      listTodo.removeAt(index); //Удаление элемента из списка
                    });
                  },
                ),
              ),
            ),
            onDismissed: (direction) {
              //слушатель события
              if (direction == DismissDirection.endToStart) {
                //событие, это смахивание с право на лево
                setState(() {
                  //метод состояния
                  listTodo.removeAt(
                      index); //конкретное действие, удаляем данный элемент из списка.
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //Новая кнопка добавления задания
        backgroundColor: Colors.cyan, //Фон кнопки
        onPressed: () {
          //Обработчик события нажатия
          showDialog(
              context: context,
              builder: (BuildContext context) {
                //Всплывающее окно ввода информации
                return AddTodo(onAddToDo: _handledAddTodo);
                  //const AddTodo();
              });
        },
        child: const Icon(
          //Дополнительная иконка на кнопке
          Icons.add_box, //конкретная библиотечная иконка
          color: Colors.indigo, //Цвет сменили у иконки
        ),
      ),
    );
  }
}
