
import 'package:brand/screens/add_post_screen.dart';
import 'package:brand/utils/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final db = FirebaseDatabase.instance.ref("Post");
  // final userDatabase = FirebaseDatabase.instance.ref("users");
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void logOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to your login screen here
      );
    } catch (e) {
      Toasts().toastMessagesAlert("Error signing out: ${e.toString()}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: searchFilter,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),

          const SizedBox(height: 20),
          // Displaying posts using FirebaseAnimatedList
          // Expanded(
          //   child: FirebaseAnimatedList(query: userDatabase, itemBuilder: (context, snapshot, animated, index){
          //     return ListTile(
          //       title: Text(snapshot.child("email").value.toString()),
          //       subtitle: Text(snapshot.child("password").value.toString()),
          //     );
          //   }) 
          //   ),
          Expanded(
            child: FirebaseAnimatedList(
                query: db,
                itemBuilder: (context, snapshot, animated, index) {
                  final title = snapshot.child("title").value.toString();

                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        trailing: PopupMenuButton<void>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<void>>[
                            PopupMenuItem<void>(
                              value: 1,
                              child: ListTile(
                                  leading: Icon(Icons.edit, color: Colors.blue),
                                  title: Text('Edit'),
                                  onTap: () {
                                    showMyDialog(context, title,
                                        snapshot.child("id").value.toString());
                                  }),
                            ),
                            PopupMenuItem<void>(
                              value: 2,
                              child: ListTile(
                                leading: Icon(Icons.delete, color: Colors.red),
                                title: Text('Delete'),
                                onTap: () {
                                  // Add your delete logic here
                                  Navigator.of(context).pop(); // Close the menu
                                  db
                                      .child(
                                          snapshot.child("id").value.toString())
                                      .remove();
                                },
                              ),
                            ),
                          ],
                          icon: Icon(Icons
                              .more_vert), // Icon to trigger the popup menu
                        ));
                  } else if (title.toLowerCase().contains(
                      searchFilter.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostsScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Show Dialog
  Future<void> showMyDialog(
      BuildContext context, String title, String id) async {
    editController.text = title; // Set the initial text in the TextField

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Corrected the builder parameters
        return AlertDialog(
          title: Text("Update"), // Correct spelling
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform the update action here
                Navigator.of(context).pop(); // Close the dialog after updating
                db.child(id).update({
                  "title": editController.text.toString(),
                }).then((value) {
                  Toasts().toastMessages("Update Data");
                }).onError((error, StackTrace) {
                  Toasts().toastMessagesAlert(error.toString());
                });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}

// get data using stream builder
//  Expanded(
//           child: StreamBuilder(
//             stream: db.onValue,
//            builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }else{
//                  Map<dynamic, dynamic>  map = snapshot.data!.snapshot.value as dynamic;
//             List<dynamic> list = [];
//             list.clear();
//             list = map.values.toList();
//                  return ListView.builder(
//               itemCount: snapshot.data!.snapshot.children.length,
//               itemBuilder: (context, index){
//               return ListTile(
//                 title: Text(list[index]["title"]),
//                 subtitle: Text(list[index]["id"]),
//               );
//             });
//             }
//            }
//            ),
//         ),
