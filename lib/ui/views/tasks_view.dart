import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/locator.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/ui/shared/shared_styles.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/ui/views/single_widget_child.dart';
import 'package:school_app/ui/widgets/busy_button.dart';
import 'package:school_app/ui/widgets/cashed_image_widget.dart';
import 'package:school_app/utils/config_size.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';
import 'package:school_app/viewmodels/tasks_view_model.dart';
import 'package:stacked/stacked.dart';

class TasksView extends SingleWidgetChild {
  final Task task;

  TasksView({this.task});

  @override
  String appBarTitle() {
    return 'Tasks';
  }

  @override
  Widget createWidget() {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ViewModelBuilder<TasksViewModel>.reactive(
        viewModelBuilder: () => TasksViewModel(),
        onModelReady: (model) =>
            model.setTaskAsRead(subjectName:task.subjectName, taskId:task.taskId),
        builder: (context, model, child) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:8.0,vertical: 8.0),
          child: Column(
            children: [
              task.imageFileName == null
                  ? SizedBox.shrink()
                  : CachedImage(
                      imageUrl: task.imageUrl,
                      height: SizeConfig.screenHeight / 3,
                      width: SizeConfig.screenWidth,
                    ),
              buildTaskCard(
                locator<NavigationService>().navigationKey.currentContext,
              ),
              verticalSpaceSmall,
              model.checkIsTeacher() || !model.isRead
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BusyButton(
                          title: kfSetUnread,
                          busy: model.busy,
                          onPressed: () {
                            model.setTaskAsUnRead(subjectName:task.subjectName, taskId:task.taskId);
                          },
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaskCard(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(16.0),
      decoration: kBoxDecorationWithRadiusAndShadow.copyWith(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            task.taskTitle,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          ReadMoreText(
            task.taskContent,
            trimLines: 3,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText:
                '...${AppLocalizations.of(context).translate(kfShowMore)}',
            trimExpandedText:
                ' ${AppLocalizations.of(context).translate(kfShowLess)}',
          ),
        ],
      ),
    );
  }
}
