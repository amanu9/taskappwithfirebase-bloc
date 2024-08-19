import 'package:equatable/equatable.dart';
import 'package:taskappwithblocandfirebase/repository/firestore_repository.dart';
import '../../models/task.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<GetAllTasks>(_getTasklist);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }
  void _getTasklist(GetAllTasks event, Emitter<TasksState> emit) async {
  List<Task> pendingTasks = [];
  List<Task> completedTasks = [];
  List<Task> favoriteTasks = [];
  List<Task> removedTasks = [];
  
  await FirestoreRepository.get().then((value) {
    value.forEach((task) {
      if (task.isDeleted == true) {
        removedTasks.add(task);
      } else {
        if (task.isFavorite == true) {
          favoriteTasks.add(task);
        }
        if (task.isDone == true) {
          completedTasks.add(task);
        } else {
          pendingTasks.add(task);
        }
      }
    });
  });

  emit(TasksState(
    pendingTasks: pendingTasks,
    completedTasks: completedTasks,
    favoriteTasks: favoriteTasks,
    removedTasks: removedTasks,
  ));
}


  void _onAddTask(AddTask event, Emitter<TasksState> emit) async{

await FirestoreRepository.crateTask(task: event.task);
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit)async {

    Task updteTask =event.task.copyWith(isDone: !event.task.isDone!);
    await FirestoreRepository.update(task:updteTask);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit)async {
    await FirestoreRepository.delete(task:event.task);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit)async {
    Task removedTasks=event.task.copyWith(isDeleted: true);
    await FirestoreRepository.update(task: removedTasks);// to update task on firestore call update function
  }
 
  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) async{
        Task? task=event.task.copyWith(isFavorite: !event.task.isFavorite!);
        await FirestoreRepository.update(task: task);
      }

  void _onEditTask(EditTask event, Emitter<TasksState> emit)async {
    await FirestoreRepository.update(task: event.newTask);
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) async{
     Task restoredTasks=event.task.copyWith(
      isFavorite: false,
      isDeleted: false,isDone: false,date: DateTime.now().toString());
    await FirestoreRepository.update(task: restoredTasks);
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit)async {

    await FirestoreRepository.deleteAllTask(taskList: state.removedTasks);

  }


}
