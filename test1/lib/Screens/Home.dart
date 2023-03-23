import 'package:flutter/material.dart';
import 'package:test1z/constants/colors.dart';
import 'package:test1z/model/toDo.dart';
import 'package:test1z/widgets/ToDoItems.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key:key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = toDo.toDoList();
  List<toDo> foundToDo = [];
  final toDoController = TextEditingController();

  @override
  void initState() {
    foundToDo = toDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500),),
                      ),
                      for(toDo todooo in foundToDo.reversed)
                      ToDoItems(
                        todo: todooo,
                        onToDoChange: handleToDoChange,
                        onDeleteItem: deleteToDoItem,
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: toDoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new ToDo Item',
                      border: InputBorder.none
                    ),
                  ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20
                  ),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40),),
                    onPressed: () {
                      addToDoItem(toDoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      )
    );
  }

  void handleToDoChange(toDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      toDoList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String toDoNow){
    setState(() {
      toDoList.add(toDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDoNow)
      );
    });
    toDoController.clear();
  }

  void runFilter(String enteredKeyword){
    List<toDo> results = [];
    if(enteredKeyword.isEmpty) {
      results = toDoList;
    } else {
      results = toDoList.
      where((item) => item.todoText!.
      toLowerCase().
      contains(enteredKeyword.
      toLowerCase())).
      toList();
    }

    setState(() {
      foundToDo = results;
    });
  }

  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              color: tdBlack,              Icons.search,

              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)

        ),
      ),


    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Icon(Icons.menu,
                  color: tdBlack,
                  size: 30,
                  ),
    );
  }
}