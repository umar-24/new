
import 'package:brand/utils/toast_message.dart';
import 'package:brand/widgets/rounded_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  final postController = TextEditingController();
  final db = FirebaseDatabase.instance.ref("Post");
  bool loading = false;
  var id =  DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void dispose() {
    postController
        .dispose(); // Dispose of the controller to avoid memory leaks.
    super.dispose();
  }

  // void addPost(){
  //   setState(() {
  //     loading = true;
  //   });
  //   var id =  DateTime.now().millisecondsSinceEpoch.toString();
  //   firestore.doc(id).set({
  //     "name": postController.text.toString(),
  //     "id": id
  //   }).then((value){
  //     Toasts().toastMessages('ADD NAME');
  //     setState(() {
  //     loading = false;
  //   });
  //   }).onError((error, StackTrace){
  //     Toasts().toastMessagesAlert(error.toString());
  //     setState(() {
  //     loading = false;
  //   });
  //   });
  // }

  void addPost() {
    setState(() {
      loading = true;
    });

    // Use push() to create a unique key for the post
    db.child(id).set({
      "id": id,
      "title": postController.text.toString(),
    }).then((value) {
      Toasts().toastMessages("Post Added");
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      Toasts().toastMessagesAlert(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post Screen")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: postController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Add Post",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            RoundedButton(
              title: "Add",
              loading: loading,
              onTap: addPost,
            ),
          ],
        ),
      ),
    );
  }
}
