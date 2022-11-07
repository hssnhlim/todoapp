import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final taskNameController = TextEditingController();
  final notesController = TextEditingController();
  final dateController = TextEditingController();

  bool isIconVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(2.5))),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Add New Task',
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            style: const TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black),
            decoration: InputDecoration(
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
                      color: Colors.red, style: BorderStyle.solid, width: 1)),
              focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red, style: BorderStyle.solid, width: 1)),
              prefixIcon: Icon(
                Icons.task,
                color: Colors.black,
              ),
            ),
            controller: taskNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter task name!';
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            style: const TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Notes',
              hintStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color(0xff929292)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              )),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1)),
              prefixIcon: Icon(
                Icons.notes,
                color: Colors.black,
              ),
            ),
            controller: notesController,
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
                    color: Colors.black,
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
                  dateController.text = DateFormat.yMMMMd().format(pickDate);
                });
              }
              ;
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
            },
          ),
        ],
      ),
    );
  }
}
