import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riv_fs_app/model/todo_task_model.dart';
import 'package:todo_riv_fs_app/services/todo_services.dart';

final servicePro = StateProvider<TodoService>((ref) {
  return TodoService();
});

final todoStreamProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoService = ref.watch(servicePro);
  return todoService.getTodoList();
});
