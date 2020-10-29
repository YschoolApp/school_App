import 'package:flutter/material.dart';
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
            _divider,
            _createDrawerItem(
                icon: Icons.book,
                text: 'Tasks',
                onTap: () {
                  model.navigateToTasksView();
                }),
            _divider,
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Sign Out',
              onTap: () => model.signOut(),
            ),
            _divider,
            _createDrawerItem(icon: Icons.event, text: 'Events'),
            _divider,
            _createDrawerItem(icon: Icons.note, text: 'Notes'),
          ],
        ),
      ),
    );
  }

  Widget _createHeader(String userName, String userEmail, String userImage) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/panner_bg.png'),
        ),
      ),
      accountName: Text(userName),
      accountEmail: Text(userEmail),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          userName,
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
