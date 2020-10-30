import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/models/lesson_model.dart';
import 'package:school_app/project_widget/eidted_table_package.dart';
import 'package:school_app/viewmodels/table_view_model.dart';
import 'package:stacked/stacked.dart';

class TableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TableViewModel>.reactive(
      viewModelBuilder: () => TableViewModel(),
      onModelReady: (model) => model.startGetLessons(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Table Screen'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 48.0),
          child: model.busy
              ? CircularProgressIndicator()
              : StickyHeadersTable(
                  columnsLength: 6,
                  rowsLength: model.arabicDays.length,
                  evenRowColor: Colors.grey.shade300.withOpacity(0.8),
                  cellDimensions: CellDimensions(
                      contentCellWidth: 100,
                      contentCellHeight: 50,
                      stickyLegendWidth: 50,
                      stickyLegendHeight: 50),
                  columnsTitleBuilder: (i) {
                    var index = i + 1;
                    return Text(index.toString());
                  },
                  rowsTitleBuilder: (i) => Text(model.arabicDays[i]),
                  contentCellBuilder: (columnIndex, rowIndex) {
                    String day = model.arabicDays[rowIndex];

                    int lessonTime = columnIndex + 1;

                    Lesson toShow = model.getLessonAt(day, lessonTime.toString());

                    return GestureDetector(
                      onTap: () {
                        model.navigateToTasks(toShow);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: model.checkIsTeacher()?buildTeacherText(toShow):buildStudentText(toShow),
                      ),
                    );
                  },
                  legendCell: Text(kfDays),
                ),
        ),
      ),
    );
  }

  Text buildTeacherText(Lesson toShow) {
    return Text(
      toShow != null ? '${toShow?.subjectName} \n ${toShow?.className}' : '-',
      textAlign: TextAlign.center,
    );
  }

    Text buildStudentText(Lesson toShow) {
    return Text(
      toShow != null ? '${toShow?.subjectName}' : '-',
      textAlign: TextAlign.center,
    );
  }
}
