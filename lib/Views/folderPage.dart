import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/Views/addNewTaskPage.dart';
import 'package:todoapp/Views/todotileTask.dart';
import 'package:todoapp/Views/widget/dialogbox.dart';
import 'package:todoapp/data/localDatabase.dart';
import 'package:todoapp/models/folder.task.model.dart';

import '../authentication/auth.provider.dart';

class FolderPage extends StatefulWidget {
  FolderPage({super.key, required this.foldertask});

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
      db.folderTask.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF3F3F3),
          title: Text(
            widget.foldertask.name! + ' Folder',
            style:
                TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: 50,
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (context) => AddNewTaskPage());
          },
          child: Icon(Icons.add),
        ));
  }
}
