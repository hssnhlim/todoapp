import 'dart:io';

import 'package:flutter/material.dart';

class uploadFileUI extends StatelessWidget {
  uploadFileUI(
      {super.key,
      required this.openFile,
      required this.path,
      required this.name});

  final VoidCallback openFile;
  final path;
  final name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: openFile,
          child: Row(
            children: [
              Image.file(
                File(path),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
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
          onPressed: () {},
          icon: Icon(
            Icons.clear,
            size: 20,
            color: Colors.black.withOpacity(.7),
          ),
        )
      ],
    );
  }
}
