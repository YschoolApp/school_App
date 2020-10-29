import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/ui/widgets/change_lang_drop_down_list_icon.dart';
import 'package:school_app/ui/widgets/drawer_widget.dart';


abstract class SingleWidgetChild extends StatelessWidget {

  Widget createWidget();
  String appBarTitle();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle()),
        actions: [
          changeLanguageDropDownList(),
        ],
      ),
      drawer: AppDrawer(),
      body: createWidget(),
    );
  }
}
