import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:patterns_provider/pages/update_page.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';

Widget itemOfPosts(BuildContext context, HomeViewModel viewModel, Post post) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    child: Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            post.title.toUpperCase(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5,),

          // Body
          Text(post.body),
        ],
      ),
    ),
    actions: [
      IconSlideAction(
        caption: 'Update',
        color: Colors.indigo,
        icon: Icons.edit,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title, body: post.body)));
        },
      ),
    ],

    secondaryActions: [
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          viewModel.apiPostDelete(post).then((value) {
            if (value) viewModel.apiPostList();
          });
        },
      ),
    ],
  );
}