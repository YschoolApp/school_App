import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/ui/widgets/task_item.dart';
import 'package:school_app/viewmodels/tasks_view_model.dart';
import 'package:stacked/stacked.dart';

class TasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksViewModel>.reactive(
      viewModelBuilder: () => TasksViewModel(),
      onModelReady: (model) => model.getQuery(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Tasks Screen'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: !model.busy
              ? Icon(Icons.add)
              : Center(child: CircularProgressIndicator()),
          onPressed: model.navigateToCreateView,
        ),
        body: FirebaseAnimatedList(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            query: model.query,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Task task = Task.fromMap(snapshot.value, snapshot.key);
              return GestureDetector(
                onTap: () => model.editTask(index),
                child: TaskItemTemplate(
                  task: task,
                  onDeleteItem: () => model.deleteTask(task),
                ),
              );
            }),
      ),
    );
  }
}
