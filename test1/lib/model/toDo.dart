class toDo {
  String? id;
  String? todoText;
  bool isDone;

  toDo({
   required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<toDo> toDoList() {
    return [
      toDo(id: '01', todoText: 'Di hoc', isDone: true),
    ];
  }
}