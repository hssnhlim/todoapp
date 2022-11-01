import 'package:hive/hive.dart';

class ToDoDatabase {
  List folderList = [];

  // reference the hive box
  final myBox = Hive.box('ToDoDatabase');

  // run this method if this is the first time opening the app
  void createInitialData() {
    folderList = ['Personal'];
  }

  // load the data from local database
  void loadData() {
    folderList = myBox.get('FOLDERLIST');
  }

  // update the database
  void updateDatabase() {
    myBox.put('FOLDERLIST', folderList);
  }
}
