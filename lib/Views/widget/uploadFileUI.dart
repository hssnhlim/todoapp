import 'dart:io';
import 'dart:math';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: openFile,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 5),
          width: double.maxFinite,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              // border: Border.all(color: Colors.black),
              // color: Colors
              //     .primaries[Random().nextInt(Colors.primaries.length)].shade200,
              borderRadius: BorderRadius.circular(8)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
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
                ))
          ]),
        ),
      ),
    );
    // Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         InkWell(
    //           onTap: openFile,
    //           child: Row(
    //             children: [
    //               // Image.file(
    //               //   File(path),
    //               //   width: 50,
    //               //   height: 50,
    //               //   fit: BoxFit.cover,
    //               // ),
    //               // const SizedBox(
    //               //   width: 15,
    //               // ),
    //               Text(
    //                 name,
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 1,
    //                 style: const TextStyle(
    //                   fontFamily: 'poppins',
    //                   fontWeight: FontWeight.w400,
    //                   fontSize: 15,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         IconButton(
    //           onPressed: (() {
    //             deleteFile;
    //           }),
    //           icon: Icon(
    //             Icons.clear,
    //             size: 20,
    //             color: Colors.black.withOpacity(.7),
    //           ),
    //         )
    //       ],
    //     ),
    //     Container(
    //       width: double.maxFinite,
    //       height: 1,
    //       decoration: BoxDecoration(
    //           color: Colors.grey.shade300,
    //           borderRadius: const BorderRadius.all(Radius.circular(2.5))),
    //     ),
    //   ],
    // );
  }
}
