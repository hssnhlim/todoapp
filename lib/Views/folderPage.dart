import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/addNewTaskPage.dart';
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
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (kDebugMode) {
                        print('Out from folder: ${widget.foldertask.name}');
                      }
                      if (kDebugMode) {
                        print('Remaining tasks: ${widget.foldertask.task}');
                      }
                    },
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    '${widget.foldertask.name!} 📂',
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                ),
              ],
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
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent))),
              controller: searchController,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 20, top: 0, bottom: 0),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 10.0),
              //   child: TextFormField(
              //     style: const TextStyle(
              //       fontFamily: 'poppins',
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //     ),
              //     cursorColor: Colors.black,
              //     decoration: InputDecoration(
              //         suffixIcon: IconButton(
              //             onPressed: () {
              //               if (searchController.text.isNotEmpty) {
              //                 setState(() {
              //                   isIconVisible = isIconVisible;
              //                 });
              //               } else {
              //                 setState(() {
              //                   isIconVisible = !isIconVisible;
              //                 });
              //               }
              //               searchController.clear();
              //             },
              //             icon: Icon(
              //               searchController.text.isNotEmpty
              //                   ? Icons.clear
              //                   : null,
              //               color: Colors.black.withOpacity(.7),
              //               size: 20,
              //             )),
              //         contentPadding: const EdgeInsets.all(10),
              //         prefixIcon: const Icon(
              //           Icons.search,
              //           color: Colors.grey,
              //         ),
              //         fillColor: Colors.grey.shade200,
              //         filled: true,
              //         hintText: 'Search',
              //         hintStyle: const TextStyle(
              //             fontFamily: 'poppins',
              //             fontWeight: FontWeight.w400,
              //             fontSize: 15,
              //             color: Colors.grey),
              //         focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide:
              //                 const BorderSide(color: Colors.transparent)),
              //         enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide:
              //                 const BorderSide(color: Colors.transparent))),
              //     controller: searchController,
              //   ),
              // ),
              // IconButton(
              //     onPressed: () {
              //       int? index;
              //       print(
              //         widget.foldertask.task.length,
              //       );
              //     },
              //     icon: const Icon(Icons.headphones)),
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Consumer<ToDoDatabase>(
                    builder: (context, value, child) {
                      if (kDebugMode) {
                        print(value.task);
                      }
                      return ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 10),
                          // itemCount: widget.foldertask.task.length,

                          itemCount: value.task.length,
                          itemBuilder: (context, index) {
                            return toDoTileTask(index, value.task[index].name);
                          });
                    },
                    // child: ListView.builder(
                    //     padding:
                    //         const EdgeInsets.only(top: 20, bottom: 20, right: 10),
                    //     // itemCount: widget.foldertask.task.length,
                    //     itemCount: widget.foldertask.task.length,
                    //     itemBuilder: (context, index) {
                    //       return toDoTileTask(index);
                    //     }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              // shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(10),
              //         topRight: Radius.circular(10))),
              context: context,
              builder: (context) => AddNewTaskPage(
                    folderTask: widget.foldertask,
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void removeTask(int index) {
    setState(() {
      widget.foldertask.task.removeAt(index);
      db.removeAt(widget.foldertask, index);
    });
  }

  Padding toDoTileTask(int index, text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => _deleteTask(index),
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          width: double.maxFinite,
          height: 79,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(5, 5) // changes position of shadow
                    ),
              ],
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  .shade200,
              borderRadius: BorderRadius.circular(8)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Checkbox(
                value: widget.foldertask.task[index].isChecked,
                onChanged: (newValue) {
                  setState(() {
                    widget.foldertask.task[index].isChecked = newValue;
                  });
                }),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ]),
        ),
      ),
    );
  }
}
