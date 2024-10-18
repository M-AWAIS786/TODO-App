import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_riv_fs_app/model/todo_task_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance
      .collection("Apptodo")
      .withConverter(
          fromFirestore: (snapshot, _) => TodoModel.fromSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap());

  //CREATE
  void addNewTask(TodoModel model) {
    todoCollection.add(model);
  }

  //READ
  Stream<List<TodoModel>> getTodoList() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  //UPDATE
  void updateNewTask(String? docId, bool? isDone) {
    todoCollection.doc(docId).update({'isdone': isDone});
  }

  //Delete
  void deleteTask(String? docId) {
    todoCollection.doc(docId).delete();
  }
}
