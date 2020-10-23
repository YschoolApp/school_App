import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/project_widget/staggered_card_template.dart';
import 'package:school_app/ui/widgets/change_lang_drop_down_list_icon.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';
import 'package:school_app/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Teacher Home'),
          actions: [
            changeLanguageDropDownList(),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                model.signOut();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          child: StaggeredGridView.count(
            crossAxisCount: 4,
            scrollDirection: Axis.vertical,
            staggeredTiles: [
              StaggeredTile.count(2, 2),
              StaggeredTile.count(2, 2),
            ],
            children: [
              CardTemplate(
                iconData: FontAwesomeIcons.bookReader,
                text: AppLocalizations.of(context).translate(kfTasks),
                onTap: () {
                  model.navigateToTasksScreen();
                },
              ),
              CardTemplate(
                iconData: FontAwesomeIcons.bookOpen,
                text: AppLocalizations.of(context).translate(kfTable),
                onTap: () {
                  model.navigateToTableScreen();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
