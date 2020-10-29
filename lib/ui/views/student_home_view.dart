import 'package:badges/badges.dart';
import 'package:school_app/models/subject_model.dart';
import 'package:school_app/ui/views/single_widget_child.dart';
import 'package:school_app/viewmodels/student_tasks_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentHomeView extends SingleWidgetChild {
  @override
  String appBarTitle() {
    return 'Home';
  }

  @override
  Widget createWidget() {
    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      viewModelBuilder: () => StudentHomeViewModel(),
      onModelReady: (model) => model.startGetData(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.busy
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                separatorBuilder: (context, index) => Divider(),
                itemCount: model.subjectsList.length,
                itemBuilder: (BuildContext _context, int index) {
                  Subject subject = model.subjectsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => model.navigateToTasksOfSubject(subject),
                      child: SubjectItem(subject: subject),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  const SubjectItem({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subject.name),
      trailing: ValueListenableBuilder(
        valueListenable: Hive.box(subject.name).listenable(),
        builder: (context, Box box, widget) {
          var foundElements = box.values.where((element) => element == false);
          return foundElements.length == 0
              ? SizedBox.shrink()
              : Badge(
                  badgeColor: Theme.of(context).primaryColor,
                  badgeContent: Text(
                    '${foundElements.length}',
                    style: TextStyle(color: Colors.white, height: 2),
                  ),
                  padding: EdgeInsets.all(8.0)
                  // child: Icon(Icons.settings),
                  );
        },
      ),
    );
  }
}
