import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
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

  // List searchFolderTask = [];

  List foundFolder = [];

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

    foundFolder = db.folderTask;

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
                }),
          );
        });
  }

  void searchFilter(String enteredKeyword) {
    List? results = [];
    if (enteredKeyword.isEmpty) {
      results = db.folderTask;
    } else {
      results = db.folderTask
          .where((folder) =>
              folder.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // print(results);
    }
    setState(() {
      foundFolder = results!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          searchController.text.isNotEmpty ? Icons.clear : null,
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
            padding:
                const EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: foundFolder.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 10),
                            itemCount: foundFolder.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageTransition(
                                      child: FolderPage(
                                        foldertask: db.folderTask[index],
                                      ),
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInCubic));
                                },
                                child: ToDoTile(
                                  folderName: foundFolder[index].name!,
                                  deleteFunction: (context) =>
                                      _deleteFolder(index),
                                ),
                              );
                            })
                        : const Center(
                            child: Text(
                            'No folder found 😞',
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
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            backgroundColor: Colors.black,
            onPressed: () {
              createNewFolder();
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  void setToDefault() {
    setState(() {
      foundFolder = db.folderTask;
    });
  }
}
