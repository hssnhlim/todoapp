import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:todoapp/Views/widget/uploadFileUI.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final taskNameController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();
  final reminderDateController = TextEditingController();
  final reminderTimeController = TextEditingController();
  // final repeatController = TextEditingController();

  bool isIconVisible = false;

  final items = ['None', 'Once', 'Every Day', 'Every Week', 'Every Month'];

  String? valueRepeat;

  PlatformFile? pickedFile;

  List<File>? files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          // centerTitle: true,
          backgroundColor: const Color(0xffF3F3F3),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: Text(
              'Add New Task',
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 30),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.black.withOpacity(.7),
                  )),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(children: [
                TextFormField(
                  minLines: 1,
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (taskNameController.text.isNotEmpty) {
                            setState(() {
                              isIconVisible = isIconVisible;
                            });
                          } else {
                            setState(() {
                              isIconVisible = !isIconVisible;
                            });
                          }
                          taskNameController.clear();
                        },
                        icon: Icon(
                          taskNameController.text.isNotEmpty
                              ? Icons.clear
                              : null,
                          color: Colors.black.withOpacity(.7),
                          size: 20,
                        )),
                    errorStyle: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.red[400]),
                    hintText: 'Task Name',
                    hintStyle: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff929292)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            style: BorderStyle.solid,
                            width: 1)),
                    focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            style: BorderStyle.solid,
                            width: 1)),
                    prefixIcon: const Icon(
                      Icons.task,
                      color: Colors.black,
                    ),
                  ),
                  controller: taskNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task name!';
                    } else if (value.length > 30) {
                      return 'Task name must below than 30 characters';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 100,
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (notesController.text.isNotEmpty) {
                            setState(() {
                              isIconVisible = !isIconVisible;
                            });
                          }
                          notesController.clear();
                        },
                        icon: Icon(
                          notesController.text.isNotEmpty ? Icons.clear : null,
                          color: Colors.black.withOpacity(.7),
                          size: 20,
                        )),
                    hintText: 'Notes',
                    hintStyle: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff929292)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    prefixIcon: const Icon(
                      Icons.notes,
                      color: Colors.black,
                    ),
                  ),
                  controller: notesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Notes null';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (dateController.text.isNotEmpty) {
                            setState(() {
                              isIconVisible = isIconVisible;
                            });
                          } else {
                            setState(() {
                              isIconVisible = !isIconVisible;
                            });
                          }
                          dateController.clear();
                        },
                        icon: Icon(
                          dateController.text.isNotEmpty ? Icons.clear : null,
                          color: Colors.black.withOpacity(.7),
                          size: 20,
                        )),
                    hintText: 'Add due date',
                    hintStyle: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff929292)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    prefixIcon: const Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                  ),
                  controller: dateController,
                  onTap: (() async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000));
                    if (pickDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat.yMMMMd().format(pickDate);
                      });
                    }
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Set Reminder 🔔',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black.withOpacity(.8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (reminderDateController.text.isNotEmpty) {
                            setState(() {
                              isIconVisible = isIconVisible;
                            });
                          } else {
                            setState(() {
                              isIconVisible = !isIconVisible;
                            });
                          }
                          reminderDateController.clear();
                        },
                        icon: Icon(
                          reminderDateController.text.isNotEmpty
                              ? Icons.clear
                              : null,
                          color: Colors.black.withOpacity(.7),
                          size: 20,
                        )),
                    hintText: 'Select Date',
                    hintStyle: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff929292)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    prefixIcon: const Icon(
                      Icons.notifications_on_outlined,
                      color: Colors.black,
                    ),
                  ),
                  controller: reminderDateController,
                  onTap: (() async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000));
                    if (pickDate != null) {
                      setState(() {
                        reminderDateController.text =
                            DateFormat.yMMMMd().format(pickDate);
                      });
                    }
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (reminderTimeController.text.isNotEmpty) {
                            setState(() {
                              isIconVisible = isIconVisible;
                            });
                          } else {
                            setState(() {
                              isIconVisible = !isIconVisible;
                            });
                          }
                          reminderTimeController.clear();
                        },
                        icon: Icon(
                          reminderTimeController.text.isNotEmpty
                              ? Icons.clear
                              : null,
                          color: Colors.black.withOpacity(.7),
                          size: 20,
                        )),
                    hintText: 'Select Time',
                    hintStyle: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff929292)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    prefixIcon: const Icon(
                      Icons.alarm,
                      color: Colors.black,
                    ),
                  ),
                  controller: reminderTimeController,
                  onTap: (() async {
                    TimeOfDay? pickTime = await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.input,
                        initialTime: TimeOfDay.now());
                    if (pickTime != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(pickTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      String formattedTime =
                          DateFormat('').add_jm().format(parsedTime);
                      setState(() {
                        reminderTimeController.text = formattedTime;
                        // DateFormat.yMMMMd().format(pickTime);
                      });
                    }
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1)),
                        prefixIcon: Icon(
                          Icons.repeat_rounded,
                          color: Colors.black,
                        )),
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black),
                    hint: const Text('Repeat',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff929292))),
                    items: items.map(
                      (valueItem) {
                        return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem,
                            ));
                      },
                    ).toList(),
                    onChanged: (newValue) => setState(() {
                          valueRepeat = newValue;
                        })),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Attachments 📂',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.black.withOpacity(.8),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: selectFile,
                      child: DottedBorder(
                        strokeWidth: 2,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [5, 5],
                        color: const Color(0xff929292),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text('Upload File',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff929292))),
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (pickedFile != null)
                  Container(
                    height: 100,
                    child: Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          itemCount: files!.length,
                          itemBuilder: (context, index) {
                            return uploadFileUI(
                              name: pickedFile!.path,
                              openFile: () {
                                OpenFilex.open(pickedFile!.path);
                              },
                            );
                          }),
                    ),
                  ),
                // const SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   children: [
                //     ElevatedButton(
                //         onPressed: () {
                //           Navigator.of(context).pop();
                //         },
                //         style: ButtonStyle(
                //             elevation: MaterialStateProperty.all(0),
                //             backgroundColor:
                //                 MaterialStateProperty.all(Colors.white),
                //             fixedSize:
                //                 MaterialStateProperty.all(const Size(92, 54)),
                //             shape: MaterialStateProperty.all(
                //                 RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(10))),
                //             side: MaterialStateProperty.all(
                //                 const BorderSide(color: Colors.black))),
                //         child: const Text(
                //           'Cancel',
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontFamily: 'poppins',
                //               fontWeight: FontWeight.w400,
                //               fontSize: 15,
                //               letterSpacing: 1),
                //         )),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //           onPressed: () {},
                //           style: ButtonStyle(
                //               elevation: MaterialStateProperty.all(0),
                //               backgroundColor:
                //                   MaterialStateProperty.all(Colors.black),
                //               fixedSize:
                //                   MaterialStateProperty.all(const Size(0, 54)),
                //               shape: MaterialStateProperty.all(
                //                   RoundedRectangleBorder(
                //                       borderRadius:
                //                           BorderRadius.circular(10)))),
                //           child: const Text(
                //             'Add Task',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontFamily: 'poppins',
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: 15,
                //                 letterSpacing: 1),
                //           )),
                //     ),
                //   ],
                // )
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: (() {}),
      ),
    );
  }

  // Method for Select File
  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result == null) return;
    // int index = files!.length;

    setState(() {
      pickedFile = result.files.first;
      files = result.paths.map((path) => File(path!)).toList();
    });
    print(result.names);
  }

  void removeSelectedFile(int index) {
    setState(() {
      files!.removeAt(index);
    });
  }
}
