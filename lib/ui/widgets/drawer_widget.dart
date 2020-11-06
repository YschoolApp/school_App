import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_app/viewmodels/drawer_view_model.dart';

import 'package:stacked/stacked.dart';

class AppDrawer extends StatelessWidget {
  final Divider _divider = Divider();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
      viewModelBuilder: () => DrawerViewModel(),
      builder: (context, model, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(
              context,
              model.currentUser.userFullName,
              model.currentUser.userEmail,
              model.currentUser.userPhone,
            ),
            _createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () {
                  model.navigateToHomeView();
                }),
            model.checkIsTeacher()
                ? _createDrawerItem(
                    icon: Icons.book,
                    text: 'Tasks',
                    onTap: () {
                      model.navigateToTasksView();
                    })
                : SizedBox.shrink(),
            _divider,
            model.checkIsParent()
                ? _createDrawerItem(
                    text: "Add Child",
                    icon: FontAwesomeIcons.table,
                    onTap: () {
                      model.navigatetoAddChildView();
                    })
                : _createDrawerItem(
                    text: 'View Table',
                    icon: FontAwesomeIcons.table,
                    onTap: () {
                      model.navigateToTableView();
                    }),
            _divider,
            _createDrawerItem(
                icon: FontAwesomeIcons.comment,
                text: 'Claim',
                onTap: () {
                  model.navigateToClaim();
                }),
            _divider,
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Sign Out',
              onTap: () => model.signOut(),
            ),
            _divider
          ],
        ),
      ),
    );
  }

  Widget _createHeader(BuildContext context, String userName, String userEmail,
      String userImage) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColor,
            BlendMode.color,
          ),
          image: AssetImage(
            'assets/images/panner_bg.png',
          ),
        ),
      ),
      accountName: Text(userName),
      accountEmail: Text(userEmail),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withGreen(80),
        child: Text(
          userName[0],
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );

    // return DrawerHeader(
    //     margin: EdgeInsets.zero,
    //     padding: EdgeInsets.zero,
    //     decoration: BoxDecoration(
    //         image: DecorationImage(
    //             fit: BoxFit.fill,
    //             image:  AssetImage('assets/images/panner_bg.png'))),
    //     child: Stack(children: <Widget>[
    //       Positioned(
    //           bottom: 12.0,
    //           left: 16.0,
    //           child: Text("Flutter Step-by-Step",
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 20.0,
    //                   fontWeight: FontWeight.w500))),
    //     ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
