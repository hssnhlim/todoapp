import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/widget/todotileFolder.dart';
import 'package:todoapp/services/notifications_service.dart';

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
  final editController = TextEditingController();

  bool isIconVisible = false;

  bool isChecked = false;

  List foundFolder = [];

  dynamic notifyHelper;

  @override
  void initState() {
    //must execute to check foldertask empty or not

    //if folder exist, this task will be ignore

    foundFolder = db.folderTask;

    super.initState();

    // initialize notifications
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  void saveNewFolder() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        var data = FolderTask(name: _controller.text, isChecked: false);
        Provider.of<ToDoDatabase>(context, listen: false).addTask(data);
        _controller.clear();
      } else {
        () => Navigator.of(context).pop();
      }
    });
    Navigator.of(context).pop();
  }

  void createNewFolder() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ZoomIn(
            duration: const Duration(milliseconds: 200),
            child: DialogBox(
              addNewFolderController: _controller,
              onSave: saveNewFolder,
              onCancel: () {
                Navigator.of(context).pop();
                _controller.clear();
              },
              text: 'Add New Task 📂',
              hintText: 'Task name',
            ),
          );
        });
  }

  void searchFilter(String enteredKeyword) {
    var list = Provider.of<ToDoDatabase>(context, listen: false).folderTask;
    List? results = [];
    if (enteredKeyword.isEmpty) {
      results = list;
      setState(() {
        foundFolder = results!;
      });
    } else {
      results = list
          .where((folder) =>
              folder.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        foundFolder = results!;
      });
    }
  }

  // my function for checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      Provider.of<ToDoDatabase>(context, listen: false).setValue(value, index);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoDatabase>(builder: (context, todo, _) {
      void deleteFolder(int index) {
        setState(() {
          todo.folderTask.removeAt(index);
        });
      }

      void saveEditFolder(int index) {
        setState(() {
          if (editController.text.isNotEmpty) {
            var data = FolderTask(
                name: editController.text.trim(),
                isChecked: todo.folderTask[index].isChecked);
            Provider.of<ToDoDatabase>(context, listen: false)
                .editTask(data, index);
            print('Data: ${data.name}');
            editController.clear();
          } else {
            () => Navigator.of(context).pop();
          }
        });
        Navigator.of(context).pop();
      }

      void editFolder(int index) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return ZoomIn(
                duration: const Duration(milliseconds: 200),
                child: DialogBox(
                  addNewFolderController: editController,
                  onSave: (() => saveEditFolder(index)),
                  onCancel: () {
                    Navigator.of(context).pop();
                    editController.clear();
                  },
                  text: 'Edit Task 📂',
                  hintText: todo.folderTask[index].name,
                  onChanged: (value) {
                    setState(() {
                      editController.text = value;
                    });
                  },
                ),
              );
            });
      }

      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            toolbarHeight: 150,
            title: Column(
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
                  onChanged: (value) => searchFilter(value),
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
                            setToDefault();
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
                          borderSide: const BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white))),
                  controller: searchController,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 20, top: 20, bottom: 0),
              child: Column(
                children: [
                  Expanded(
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: todo.folderTask.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 10),
                              itemCount: searchController.value.text.isNotEmpty
                                  ? foundFolder.length
                                  : todo.folderTask.length,
                              itemBuilder: (context, index) {
                                return ToDoTile(
                                    folderName:
                                        searchController.value.text.isNotEmpty
                                            ? foundFolder[index].name
                                            : todo.folderTask[index].name!,
                                    deleteFunction: (context) =>
                                        deleteFolder(index),
                                    editFunction: (context) =>
                                        editFolder(index),
                                    isChecked: searchController
                                            .value.text.isNotEmpty
                                        ? foundFolder[index].isChecked
                                        : todo.folderTask[index].isChecked ??
                                            false,
                                    onChanged: (value) =>
                                        checkBoxChanged(value, index));
                              })
                          : const Center(
                              child: Text(
                              'No task available 😞',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FadeInRight(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: FloatingActionButton.extended(
                label: const Text(
                  'Add Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 1),
                ),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                onPressed: () {
                  createNewFolder();
                },
              )));
    });
  }

  void setToDefault() {
    setState(() {
      foundFolder = db.folderTask;
    });
  }
}
