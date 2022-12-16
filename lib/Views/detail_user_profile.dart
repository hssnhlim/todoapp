import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Views/edit_profile.dart';
import 'package:todoapp/authentication/auth.provider.dart';

class DetailUserProfile extends StatefulWidget {
  const DetailUserProfile({Key? key}) : super(key: key);

  @override
  State<DetailUserProfile> createState() => _DetailUserProfileState();
}

class _DetailUserProfileState extends State<DetailUserProfile> {
  void editUsersPage(DocumentSnapshot documentSnapshot) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (context) => EditProfilePage(
              documentSnapshot: documentSnapshot,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'User Profile',
        style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
        maxLines: 1,
      )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            StreamBuilder(
                stream: getUsersDetail(context)
                    .map((snapshot) => snapshot.docs.toList()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  snapshot.data![index];

                              return Column(
                                children: [
                                  profileSection(
                                      '${documentSnapshot['name']}',
                                      '${documentSnapshot['email']}',
                                      '${documentSnapshot['phone']}'),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: btnEditUsers(
                                            () =>
                                                editUsersPage(documentSnapshot),
                                            'Edit Profile'),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            // Row(
            //   children: [
            //     Expanded(
            //       child: btnEditUsers(editUsersPage, 'Edit Profile'),
            //     )
            //   ],
            // )
          ],
        ),
      )),
    );
  }
}

Widget btnEditUsers(addFunction, text) {
  return ElevatedButton(
      onPressed: addFunction,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          fixedSize: MaterialStateProperty.all(const Size(0, 54)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            fontSize: 17,
            letterSpacing: 1),
      ));
}

Stream<QuerySnapshot> getUsersDetail(BuildContext context) async* {
  final uid =
      await Provider.of<AuthProvider>(context, listen: false).getCurrentUID();
  yield* FirebaseFirestore.instance
      .collection('users')
      .orderBy('id', descending: true)
      .snapshots();
}

Widget profileSection(text1, text2, text3) {
  return Column(
    children: [
      Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(5, 5) // changes position of shadow
                ),
          ],
        ),
        child: Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Name: $text1',
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(5, 5) // changes position of shadow
                ),
          ],
        ),
        child: Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Email: $text2',
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(5, 5) // changes position of shadow
                ),
          ],
        ),
        child: Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Phone: $text3',
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
