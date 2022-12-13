import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.folderName,
      required this.deleteFunction,
      required this.editFunction,
      required this.isChecked,
      required this.onChanged});

  final String folderName;
  final bool isChecked;
  Function(BuildContext?)? deleteFunction;
  Function(BuildContext?)? editFunction;
  void Function(bool?)? onChanged;

  // final FolderTask folderTask;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(5),
            ),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade600,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
        child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(5, 5) // changes position of shadow
                      ),
                ],
                color: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]
                    .shade200,
                borderRadius: BorderRadius.circular(5)),
            child: ListTile(
              leading: Checkbox(
                  fillColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(.8)),
                  value: isChecked,
                  onChanged: onChanged),
              title: Text(
                folderName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            )),
      ),
    );
  }
}
