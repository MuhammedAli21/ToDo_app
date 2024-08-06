import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/data_classes/my_user.dart';
import 'package:todo_app/data_classes/task.dart';

class FirebaseUtils{
  static CollectionReference<Task> getTasksCollection(String uId){
    return
      getUsersCollection().doc(uId).collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: (snapshot,options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (task,option) => task.toFireStore()
    );
  }

  static Future<void> addTaskToFireStore(Task task,String uId){
    var taskCollection = getTasksCollection(uId); //collection
    DocumentReference<Task> taskDocRef = taskCollection.doc(); //document
    task.id = taskDocRef.id; //auto ID
    return taskDocRef.set(task);
  }

  
  static Future<void> deleteTaskFromFireStore(Task task,String uId){
   return getTasksCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection(){
    //todo : لو فيه كوليكشن بتروح تجيبه لو مفيش بتعمل واحد بالاسم

    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
        fromFirestore: (snapshot , _) => MyUser.fromFireStore(snapshot.data()) ,
        toFirestore: (user , _ ) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser user){
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String uId)async{
    //todo : read data
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }
}