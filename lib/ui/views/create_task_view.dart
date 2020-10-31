import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/ui/widgets/busy_button.dart';
import 'package:school_app/ui/widgets/drop_down_menu.dart';
import 'package:school_app/ui/widgets/input_text.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';
import 'package:school_app/viewmodels/create_task_view_model.dart';
import 'package:stacked/stacked.dart';

class CreateTaskView extends StatelessWidget {
  // final taskController = TextEditingController();
  // final Task edittingTask;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  // CreateTaskView({Key key, this.edittingTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateTaskViewModel>.reactive(
      viewModelBuilder: () => CreateTaskViewModel(),
      onModelReady: (model) {
        model.getClassAndSubject();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Create Task'),
        ),
        body: model.busy
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FormBuilder(
                          key: _fbKey,
                          child: Column(
                            children: <Widget>[
                              DropDownMenu(
                                isExpanded: true,
                                attributeKey: 'class',
                                hintText: 'class',
                                labelText: 'class',
                                list: model.classesList
                                    .map((e) => e.name)
                                    .toSet()
                                    .toList(),
                              ),
                              verticalSpaceMedium,
                              DropDownMenu(
                                isExpanded: true,
                                hintText: kfSubject,
                                attributeKey: 'subject',
                                labelText: kfSubject,
                                list: model.subjectsList
                                    .map((e) => e.name)
                                    .toSet()
                                    .toList(),
                                // textEditingController: _bodyController,
                              ),
                              verticalSpaceMedium,
                              InputTextForm(
                                attributeKey: 'taskTitle',
                                kfHintText: kfTaskTitle,
                                kfLabelText: kfTaskTitle,
                                autoFocus: false,
                                // textEditingController: _bodyController,
                                minLine: 1,
                              ),
                              verticalSpaceMedium,
                              InputTextForm(
                                attributeKey: 'taskContent',
                                kfHintText: kfContent,
                                kfLabelText: kfContent,
                                autoFocus: false,
                                // textEditingController: _bodyController,
                                minLine: 7,
                              ),
                              verticalSpaceMedium,
                              FormBuilderImagePicker(
                                attribute: 'images',
                                validators: [
                                  // FormBuilderValidators.max(3),
                                  (val) {
                                    if (_fbKey.currentState.fields['images']
                                            .currentState.value.length >=
                                        3) {
                                      return 'photo must be 3 or less';
                                    } else {
                                      return null;
                                    }
                                  }
                                ],
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 15.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                              verticalSpaceMedium,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: BusyButton(
                                  title: kfSubmit,
                                  busy: model.busy,
                                  onPressed: () {
                                    model.submitData(_fbKey);
                                  },
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(
      {BuildContext context,
      String text,
      IconData icon,
      Color iconColor,
      Function onTab}) {
    return FloatingActionButton.extended(
      heroTag: UniqueKey(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      onPressed: onTab,
      label: Text(AppLocalizations.of(context).translate(text)),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

// Visibility(
//     visible:
//         model.selectedImage == null ? false : true,
//     child: Container(
//       child: model.selectedImage == null
//           ? SizedBox.shrink()
//           : Image.file(model.selectedImage),
//     ),
// ),
// verticalSpaceMedium,
// Row(
//   mainAxisAlignment:
//       MainAxisAlignment.spaceEvenly,
//   children: [
//     buildFloatingActionButton(
//       context: context,
//       text: kfUploadPdf,
//       icon: FontAwesomeIcons.image,
//       iconColor: Colors.red,
//       onTab: () {
//         bottomSheetWidget(
//           context: context,
//           screenHeightMinus: 470,
//           body: Column(
//             children: [
//               ListTile(
//                 onTap: () => model.selectImage(
//                     ImageSource.camera),
//                 leading: CircleAvatar(
//                     child: Icon(
//                   FontAwesomeIcons.camera,
//                 )),
//                 title: Text('Camera'),
//               ),
//               Divider(),
//               ListTile(
//                 onTap: () => model.selectImage(
//                     ImageSource.gallery),
//                 leading: CircleAvatar(
//                   child: Icon(
//                       FontAwesomeIcons.images),
//                 ),
//                 title: Text('Gallery'),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   ],
// ),

// GestureDetector(
//   // When we tap we call selectImage
//   onTap: () => model.selectImage(),
//   child: Container(
//     height: 250,
//     decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(10)),
//     alignment: Alignment.center,
//     // If the selected image is null we show "Tap to add post image"
//     child: model.selectedImage == null
//         ? Text(
//       'Tap to add post image',
//       style: TextStyle(color: Colors.grey[400]),
//     )
//     // If we have a selected image we want to show it
//         : Image.file(model.selectedImage),
//   ),
// )

// builder: (context, model, child) => Scaffold(
//     floatingActionButton: FloatingActionButton(
//       child: !model.busy
//           ? Icon(Icons.add)
//           : CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation(Colors.white),
//             ),
//       onPressed: () {
//         if (!model.busy) {
//           model.addTask(task: taskController.text);
//         }
//       },
//       backgroundColor:
//           !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
//     ),
//     body: SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           verticalSpace(40),
//           Text(
//             'Create Task',
//             style: TextStyle(fontSize: 26),
//           ),
//           verticalSpaceMedium,
//           Text('Task'),
//           verticalSpaceSmall,
//           GestureDetector(
//             // When we tap we call selectImage
//             onTap: () => model.selectImage(),
//             child: Container(
//               child: TextField(
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 10,
//                 controller: taskController,
//               ),
//             ),
//           ),
//         ],
//       ),
//     )),
