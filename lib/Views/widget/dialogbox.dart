import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  DialogBox(
      {super.key,
      required this.addNewFolderController,
      required this.onCancel,
      required this.onSave});

  final addNewFolderController;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Folder:',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: onCancel,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                )),
            SizedBox(
              width: 10,
            ),
            TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: onSave,
                child: Text(
                  'Okay',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ))
          ],
        ),
      ],
      backgroundColor: Color(0xffF3F3F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: TextFormField(
        style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black),
        // The validator receives the text that the user has entered.
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter your folder name',
          hintStyle: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xff929292)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.5)),
        ),
        controller: addNewFolderController!,
      ),
    );
  }
}
