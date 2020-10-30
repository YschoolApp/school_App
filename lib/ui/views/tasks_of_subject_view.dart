import 'package:flutter/material.dart';
import 'package:school_app/models/subject_model.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/ui/views/single_widget_child.dart';
import 'package:school_app/ui/widgets/task_item_template.dart';
import 'package:school_app/viewmodels/tasks_of_subject_view_model.dart';
import 'package:stacked/stacked.dart';

class TasksOfSubjectView extends SingleWidgetChild {
  final Subject subject;

  TasksOfSubjectView({this.subject});

  @override
  String appBarTitle() {
    return 'Tasks of ${subject.name}';
  }

  @override
  Widget createWidget() {
    return ViewModelBuilder<TasksOfSubjectViewModel>.reactive(
      viewModelBuilder: () => TasksOfSubjectViewModel(),
      onModelReady: (model) => model.startGettingData(id: subject?.id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: StreamBuilder(
          stream: model.getStream(),
          builder: (BuildContext _context, AsyncSnapshot _snapshot) {
            if (_snapshot.hasData) {
              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                separatorBuilder: (context, index) => Divider(),
                itemCount: _snapshot.data.length + 1,
                itemBuilder: (BuildContext _context, int index) {
                  if (index < _snapshot.data.length) {
                    Task task = _snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (task.subjectName == null) {
                            task.subjectName = subject.name;
                          }
                          model.navigatetoTaskView(task);
                        },
                        child: TaskItemTemplate(
                          isTeacher: model.checkIsTeacher(),
                          subjectName: subject?.name,
                          task: task,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(
                        child: Text('no more item'),
                      ),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Text('no item'),
              );
            }
          },
        ),
      ),
    );
  }
}

// class TaskTemplate extends StatelessWidget {
//   const TaskTemplate({
//     Key key,
//     @required this.task,
//     @required this.subjectName,
//   }) : super(key: key);

//   final Task task;
//   final String subjectName;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(task.subjectName),
//       subtitle: Text(task.taskContent),
//       trailing: ValueListenableBuilder(
//         valueListenable: Hive.box(task.subjectName).listenable(),
//         builder: (context, Box box, widget) {
//           bool isRead = box.get('${task.taskId}') ?? false;
//           if (!isRead) {
//             box.put('${task.taskId}', false);
//           }
//           return isRead
//               ? SizedBox.shrink()
//               : GestureDetector(
//                   onTap: () {
//                     box.put(
//                       '${task.taskId}',
//                       !isRead,
//                     );
//                   },
//                   child: Badge(
//                     shape: BadgeShape.square,
//                     badgeColor: Theme.of(context).primaryColor,
//                     borderRadius: BorderRadius.circular(8),
//                     badgeContent: Text(
//                       isRead ? 'read' : 'unread',
//                       style: TextStyle(color: Colors.white, height: 2),
//                     ),
//                     padding: EdgeInsets.all(8.0),
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }
