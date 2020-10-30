import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_app/models/task.dart';
import 'cashed_image_widget.dart';

class TaskItemTemplate extends StatelessWidget {
  final Task task;
  final Function onDeleteItem;
  final String subjectName;
  final isTeacher;

  const TaskItemTemplate({
    Key key,
    this.task,
    this.onDeleteItem,
    this.subjectName,
    @required this.isTeacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(5.0, 5.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                child: CachedImage(
                  imageUrl: task.imageUrl ?? '',
                  height: 100,
                  width: 120,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(task.subjectName ?? subjectName),
                      Text(task.taskTitle ?? ''),
                      AutoSizeText(
                        task.taskContent ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            task.uploadTime.toString() ?? '',
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        isTeacher
            ? SizedBox.shrink()
            : Positioned(
                right: 10,
                top: 10,
                child: buildBadge(),
              ),
      ],
    );
  }

  ValueListenableBuilder<Box> buildBadge() {
    return ValueListenableBuilder(
      valueListenable: Hive.box(task.subjectName).listenable(),
      builder: (context, Box box, widget) {
        bool isRead = box.get('${task.taskId}') ?? false;
        if (!isRead) {
          box.put('${task.taskId}', false);
        }
        return isRead
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  box.put(
                    '${task.taskId}',
                    !isRead,
                  );
                },
                child: isRead
                    ? SizedBox.shrink()
                    : Badge(
                        shape: BadgeShape.square,
                        badgeColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: Text(
                          'unread',
                          style: TextStyle(color: Colors.white, height: 1),
                        ),
                        padding: EdgeInsets.all(8.0),
                      ),
              );
      },
    );
  }
}
