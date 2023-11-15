import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? _userToDo;
  List listTodo = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFirebase();
    
    listTodo.addAll(['купить картошку.', 'Написать код.', 'Помыть посуду.']);
  }

  void _menuOpen(){ //Метод обработки нажатия кнопки IconButton
    Navigator.of(context).push(  //Навигатор осуществляет все переходы
      MaterialPageRoute(builder: (BuildContext context){ //Стандартный виджет
        return Scaffold(
          appBar: AppBar(  //Заполняем шапку
            title: const Text('Меню'),
          ),
          body:Row(    //новая строчка
            children: [
              ElevatedButton(onPressed: (){ //кнопка
                Navigator.pop(context); //Снова обращаемся к Навигатору, который отвечает за переходы. Метод pop() закрывает виджет, в котором вызван
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); //А тут мы обращаемся к открытию другого выджита, но так как используем '/', то вернёмся в главное меню.
              }, child: const Text('Главное Меню')), //Надпись на кнопке
              const Padding(padding: EdgeInsets.only(left: 20)), //Отступ
              const Text('Наше простое Меню')
            ],
          ),
        );
      }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Список дел'),
        centerTitle: true,
        actions: [ //Добавляем активное поле в поле AppBar
          IconButton(onPressed: _menuOpen, //Добавляем кнопку-иконку
              icon: const Icon(Icons.menu_open_outlined), //теперь подбираем иконку для кнопки
          ),
        ],
      ),
      body: ListView.builder( //Указываем как будет построен весь наш список
        itemCount: listTodo.length, //длинну списка можно задать цифрой, а можно привязаться к длинне списка
          itemBuilder: (BuildContext context, int index){
          return  Dismissible(   //возврат каждого отдельного элемента. Можно через Text() и будет выводится каждый элемент
              key: Key(listTodo[index]), //но мы будем делать выборку через изъятие с удалением из списка элемента по индексу
              child: Card( //на каждый элемент списка выводим карточку, в которой может быть в содержании картинка, заголовок и т.д.
                child: ListTile(  //это будет заголовок карточки. А через ListBody описание содержимого
                  title: Text(listTodo[index]), //Заголовок согласно элемента списка
                  trailing: IconButton( //добавляем иконку-кнопку удаления
                    icon: const Icon( //выбираем изображения иконки
                      Icons.delete_sweep, //изображение
                      color: Colors.red, //цвет иконки
                    ), onPressed: () {  //Слушатель этой кнопки
                      setState(() { //Отрисовка Состояния
                        listTodo.removeAt(index); //Удаление элемента из списка
                      });
                      print(listTodo); //проверяем заполненность списка.
                  },
                  ),
                ),
              ),
            onDismissed: (direction){ //слушатель события
                if (direction == DismissDirection.endToStart) //событие, это смахивание с право на лево
                setState(() {   //метод состояния
                  listTodo.removeAt(index);  //конкретное действие, удаляем данный элемент из списка.
                });
                print(listTodo); //проверяем заполненность списка.
            },
          );
          },
      ),
      floatingActionButton: FloatingActionButton( //Новая кнопка добавления задания
        backgroundColor: Colors.cyan, //Фон кнопки
        onPressed: () { //Обработчик события нажатия
          showDialog(context: context, builder: (BuildContext context){ //Всплывающее окно ввода информации
            return AlertDialog(
              title: const Text('Добавить элемент'), //Заголовок окна
              content: TextField( //текстовое поле ввода информации, хотя можно было отобразить объект Row и много различных виджетов
                onChanged: (String value){ //действие после ввода
                  _userToDo = value; //набранный текст заносим в переменную
                },
              ),
              actions: [ //Добавляем кнопку добавления значения и закрытия всплывающего окна
                // ElevatedButton(
                //   onPressed: (){ //обработка нажатия
                //     //FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                //     FirebaseDatabase.instance.reference()
                //     .child('items').push().set({'item': _userToDo});
                //   Navigator.of(context).pop();//при нажатии кнопки, нужно закрыть все всплывающие окна
                // }, child: const Text('Добавить'), //надпись на кнопке
                // ),
                ElevatedButton(
                  onPressed: () async {
                    // await Firebase.initializeApp(); // Инициализация FirebaseApp
                    // final databaseReference = FirebaseDatabase.instance.reference();
                    // databaseReference.child('items').push().set({'item': _userToDo});
                    // Navigator.of(context).pop();
                    setState(() { //это будет в блоке состояния, так как графика должна перерисовываться
                      listTodo.add(_userToDo); //добавляем в список новую запись
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text('Добавить'),
                ),
              ],
            );
          });
        },
        child: const Icon( //Дополнительная иконка на кнопке
    Icons.add_box,  //конкретная библиотечная иконка
          color: Colors.indigo, //Цвет сменили у иконки
        ),

      ),
    );
  }
}
