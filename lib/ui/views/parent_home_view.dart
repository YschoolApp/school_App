import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/project_widget/staggered_card_template.dart';
import 'package:school_app/ui/views/single_widget_child.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';
import 'package:school_app/viewmodels/home_view_model.dart';


class ParentHomeView extends SingleWidgetChild {


  @override
  String appBarTitle() {
    // TODO: implement appBarTitle
    return 'My Children';
  }

  @override
  Widget createWidget() {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) =>
          Scaffold(
            backgroundColor: Colors.white,
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
                    iconData: FontAwesomeIcons.users,
                    text: AppLocalizations.of(context).translate(kfChild),
                    onTap: () {
                      model.navigateToChildrenScreen();
                    },
                  ),
                  CardTemplate(
                    iconData: FontAwesomeIcons.table,
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