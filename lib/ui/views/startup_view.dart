import 'package:flutter/material.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/utils/config_size.dart';
import 'package:school_app/viewmodels/startup_view_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/splash.png',
                alignment: Alignment.center,
                height: SizeConfig.screenHeight / 2,
                width: SizeConfig.screenWidth,
              ),
              verticalSpaceSmall,
              Text(
                'eSchool',
                style: Theme.of(context).textTheme.headline5,
              ),
              verticalSpaceLarge,
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
