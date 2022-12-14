// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class ToDoTileTask extends StatelessWidget {
//   ToDoTileTask(
//       {super.key, required this.taskName, required this.deleteFunction});

//   Function(BuildContext)? deleteFunction;

//   final String taskName;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: const BehindMotion(),
//           children: [
//             SlidableAction(
//               onPressed: deleteFunction,
//               icon: Icons.delete,
//               backgroundColor: Colors.red,
//               borderRadius: BorderRadius.circular(8),
//             )
//           ],
//         ),
//         child: Container(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           width: double.maxFinite,
//           height: 79,
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey.withOpacity(0.4),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: const Offset(5, 5) // changes position of shadow
//                     ),
//               ],
//               color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
//                   .shade200,
//               borderRadius: BorderRadius.circular(8)),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(
//               taskName,
//               style: const TextStyle(
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 20),
//             ),
//             const Icon(Icons.keyboard_arrow_right_outlined)
//           ]),
//         ),
//       ),
//     );
//   }
// }
