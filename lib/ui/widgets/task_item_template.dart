import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';

class TaskItemTemplate extends StatelessWidget {
  final Task task;
  final Function onDeleteItem;

  const TaskItemTemplate({
    Key key,
    this.task,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
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
              borderRadius:
              BorderRadius.all(
                Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) =>
                    Container(
                      height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                imageUrl: task.imageUrl??'',
                errorWidget: (context, url, error) =>
                  // Icon(FontAwesomeIcons.image,size: 80,color: Theme.of(context).primaryColor,),
                Image.asset(
                  'assets/images/image_placeholder.png',
                  height: 100,
                  width: 120,
                ),
                placeholder: (context, url) =>
                    Image.asset(
                      'assets/images/image_placeholder.png',
                      height: 100,
                      width: 120,
                    ),
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
                          '${task.uploadTime.toString()}',
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
      );
    //   Container(
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //           child: Padding(
    //         padding: const EdgeInsets.only(left: 15.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Text(task.taskContent),
    //           ],
    //         ),
    //       )),
    //       IconButton(
    //         icon: Icon(Icons.close),
    //         onPressed: () {
    //           if (onDeleteItem != null) {
    //             onDeleteItem();
    //           }
    //         },
    //       ),
    //     ],
    //   ),
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(5),
    //       boxShadow: [
    //         BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
    //       ]),
    // );
  }
}
