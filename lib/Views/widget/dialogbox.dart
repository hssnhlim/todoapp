import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox(
      {super.key,
      this.onChanged,
      required this.text,
      required this.hintText,
      required this.addNewFolderController,
      required this.onCancel,
      required this.onSave});

  final addNewFolderController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final text;
  final hintText;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.all(const BorderSide(
                      width: 1,
                    )),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: onCancel,
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                )),
            const SizedBox(
              width: 10,
            ),
            TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: onSave,
                child: const Text(
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
      backgroundColor: const Color(0xffF3F3F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: TextFormField(
        minLines: 1, maxLines: 2,
        style: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black),
        // The validator receives the text that the user has entered.
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.task_outlined,
            color: Colors.black,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xff929292)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)),
        ),
        controller: addNewFolderController!, onChanged: (value) => onChanged,
      ),
    );
  }
}
