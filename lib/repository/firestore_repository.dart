import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../models/task.dart';

class FirestoreRepository{

  //add task to firebase
static Future<void> crateTask({Task? task})async{

  try{
    await FirebaseFirestore.instance.collection(GetStorage().read('email'))//to get email 
    .doc(task!.id)// unique id for each docs
    .set(task!.toMap());// setting data

  }catch(e){
  throw Exception(e.toString());

  }

}


  // get all task list 


  static Future<List<Task>> get()async{
      List<Task> taskList=[];
    try{
      final data= await FirebaseFirestore.instance.collection(GetStorage().read('email')).get();

for(var task in data.docs){
  taskList.add(Task.fromMap(task.data()));

}
 return taskList;
     
    }catch(e){
      throw Exception(e.toString());


    }
   
  }
  // update task 

  static Future<void> update({Task? task})async{
    try{
      final data=FirebaseFirestore.instance.collection(GetStorage().read('email'));
      data.doc(task!.id).update(task.toMap());// find task by id and update it

    }catch(e){
throw Exception(e.toString());
    }
  }
  //delete task
  static Future<void> delete({Task? task})async{
    try{
      final data=FirebaseFirestore.instance.collection(GetStorage().read('email'));
      data.doc(task!.id).delete();// find task by id and update it

    }catch(e){
throw Exception(e.toString());
    }
  }
  static Future<void> deleteAllTask({List<Task>? taskList})async{
    try{
      final data=FirebaseFirestore.instance.collection(GetStorage().read('email'));
      for(var task in taskList!){
data.doc(task!.id).delete();
      }

    }catch(e){
throw Exception(e.toString());
    }
  }
}