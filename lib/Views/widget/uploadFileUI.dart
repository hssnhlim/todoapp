import 'dart:io';

import 'package:flutter/material.dart';

class uploadFileUI extends StatelessWidget {
  uploadFileUI(
      {super.key,
      this.openFile,
      this.path,
      required this.name,
      this.deleteFile});

  final VoidCallback? openFile;
  final path;
  final name;
  Function(BuildContext)? deleteFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: openFile,
              child: Row(
                children: [
                  // Image.file(
                  //   File(path),
                  //   width: 50,
                  //   height: 50,
                  //   fit: BoxFit.cover,
                  // ),
                  // const SizedBox(
                  //   width: 15,
                  // ),
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: (() {
                deleteFile;
              }),
              icon: Icon(
                Icons.clear,
                size: 20,
                color: Colors.black.withOpacity(.7),
              ),
            )
          ],
        ),
        Container(
          width: double.maxFinite,
          height: 1,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(2.5))),
        ),
      ],
    );
  }
}
