import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile({super.key, required this.folderName, required this.deleteFunction});

  final String folderName;

  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const FolderPage()),
          // );
        },
        child: Slidable(
          endActionPane: ActionPane(
            motion: BehindMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
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
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    folderName,
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                  Icon(Icons.keyboard_arrow_right_outlined)
                ]),
          ),
        ),
      ),
    );
  }
}
