import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/Views/addNewTaskPage.dart';
import 'package:todoapp/Views/todotileTask.dart';
import 'package:todoapp/data/localDatabase.dart';
import 'package:todoapp/models/folder.task.model.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key, required this.foldertask});

  final FolderTask foldertask;

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  ToDoDatabase db = ToDoDatabase();

  // reference the hive box
  final myBox = Hive.box('ToDoDatabase');

  void _deleteTask(int index) {
    setState(() {
      widget.foldertask.task.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF3F3F3),
          title: Text(
            '${widget.foldertask.name!} 📂',
            style: const TextStyle(
                fontFamily: 'poppins', fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ToDoTileTask(
                      taskName: 'Task Name',
                      deleteFunction: (context) => _deleteTask(index),
                    );
                  })),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                context: context,
                builder: (context) => const AddNewTaskPage());
          },
          child: const Icon(Icons.add),
        ));
  }
}
