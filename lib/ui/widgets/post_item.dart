import 'package:cached_network_image/cached_network_image.dart';
import 'package:school_app/models/post.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function onDeleteItem;
  const TaskItem({
    Key key,
    this.task,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Text(task.title),
              ],
            ),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    );
  }
}
