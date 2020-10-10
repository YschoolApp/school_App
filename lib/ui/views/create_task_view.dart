import 'package:flutter/material.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/viewmodels/create_post_view_model.dart';
import 'package:stacked/stacked.dart';

class CreateTaskView extends StatelessWidget {
  final taskController = TextEditingController();
  final Task edittingTask;

  CreateTaskView({Key key, this.edittingTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateTaskViewModel>.reactive(
      viewModelBuilder: () => CreateTaskViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        taskController.text = edittingTask?.task ?? '';

        model.setEdittingTask(edittingTask);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy) {
                model.addTask(task: taskController.text);
              }
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Create Task',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                // InputField(
                //   placeholder: 'Title',
                //   controller: titleController,
                // ),titleController
                verticalSpaceMedium,
                Text('Task'),
                verticalSpaceSmall,
                GestureDetector(
                  // When we tap we call selectImage
                  onTap: () => model.selectImage(),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      controller: taskController,

                    ),
                  ),
                ),
                RaisedButton(
                    child: Text("Send",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                    onPressed: (){
                      print(taskController.text);
                      model.addTask(task: taskController.text);
                    })
              ],
            ),
          )),
    );
  }
}
