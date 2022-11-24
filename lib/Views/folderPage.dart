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

  final searchController = TextEditingController();

  bool isIconVisible = false;

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
                const EdgeInsets.only(left: 30, right: 20, top: 0, bottom: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                setState(() {
                                  isIconVisible = isIconVisible;
                                });
                              } else {
                                setState(() {
                                  isIconVisible = !isIconVisible;
                                });
                              }
                              searchController.clear();
                            },
                            icon: Icon(
                              searchController.text.isNotEmpty
                                  ? Icons.clear
                                  : null,
                              color: Colors.black.withOpacity(.7),
                              size: 20,
                            )),
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent))),
                    controller: searchController,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 20, right: 10),
                      // itemCount: widget.foldertask.task.length,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ToDoTileTask(
                          taskName: 'Task Name',
                          deleteFunction: (context) => _deleteTask(index),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                // shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(10),
                //         topRight: Radius.circular(10))),
                context: context,
                builder: (context) => const AddNewTaskPage());
          },
          child: const Icon(Icons.add),
        ));
  }
}
