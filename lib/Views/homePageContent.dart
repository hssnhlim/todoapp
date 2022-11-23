import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/Views/folderPage.dart';
import 'package:todoapp/Views/widget/todotileFolder.dart';

import '../data/localDatabase.dart';
import '../models/folder.task.model.dart';
import 'widget/dialogbox.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  // reference the hive box
  final myBox = Hive.box('ToDoDatabase');

  ToDoDatabase db = ToDoDatabase();

  // List folderList = [];

  final _controller = TextEditingController();
  final searchController = TextEditingController();

  bool isIconVisible = false;

  @override
  void initState() {
    //must execute to check foldertask empty or not
    db.loadData();
    //if folder exist, this task will be ignore
    if (db.folderTask.isEmpty) {
      // if this is the first time opening the app
      // then create the default data
      db.createInitialData();
    }
    super.initState();
  }

  void saveNewFolder() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        db.folderTask.add(FolderTask(name: _controller.text, task: []));
        _controller.clear();
      } else {
        () => Navigator.of(context).pop();
      }
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void _deleteFolder(int index) {
    setState(() {
      db.folderTask.removeAt(index);
    });
    db.updateDatabase();
  }

  void createNewFolder() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              addNewFolderController: _controller,
              onSave: saveNewFolder,
              onCancel: () {
                Navigator.of(context).pop();
                _controller.clear();
              });
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tasks',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                // Align(
                //   alignment: Alignment.topRight,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       AuthProvider.instance.signOut(context);
                //     },
                //     child: const Text(
                //       'Logout',
                //       style: TextStyle(
                //         fontFamily: 'poppins',
                //         fontWeight: FontWeight.w600,
                //         fontSize: 20,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      itemCount: db.folderTask.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FolderPage(
                                        foldertask: db.folderTask[index],
                                      )),
                            );
                          },
                          child: ToDoTile(
                            folderName: db.folderTask[index].name!,
                            deleteFunction: (context) => _deleteFolder(index),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.black,
          onPressed: () {
            createNewFolder();
          },
          child: const Icon(Icons.add),
        ));
  }
}
