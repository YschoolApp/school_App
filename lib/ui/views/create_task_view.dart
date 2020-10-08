import 'package:flutter/material.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/ui/widgets/input_field.dart';
import 'package:school_app/viewmodels/create_post_view_model.dart';
import 'package:stacked/stacked.dart';


class CreateTaskView extends StatelessWidget {
  final titleController = TextEditingController();
  final Task edittingTask;
  CreateTaskView({Key key, this.edittingTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateTaskViewModel>.reactive(
      viewModelBuilder:()=> CreateTaskViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = edittingTask?.title ?? '';

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
                model.addTask(title: titleController.text);
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
                  'Create Post',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Title',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                Text('Task'),
                verticalSpaceSmall,
                GestureDetector(
                  // When we tap we call selectImage
                  onTap: () => model.selectImage(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    // If the selected image is null we show "Tap to add post image"
                    child: model.selectedImage == null
                        ? Text(
                            'Tap to add post image',
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        // If we have a selected image we want to show it
                        : Image.file(model.selectedImage),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
