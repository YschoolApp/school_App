import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/ui/widgets/busy_button.dart';
import 'package:school_app/ui/widgets/input_field.dart';
import 'package:school_app/ui/widgets/logo_icon.dart';
import 'package:school_app/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:school_app/viewmodels/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder:()=> LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child:  LogoIcon(screenName: kfLogIn, tag: 'logo1',
                      assetPath: 'assets/images/login.svg',),
                  ),
                  InputField(
                    placeholder: kfEmail,
                    controller: emailController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: kfPassword,
                    password: true,
                    controller: passwordController,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BusyButton(
                        title: kfLogIn,
                        busy: model.busy,
                        onPressed: () {
                          model.login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                      )
                    ],
                  ),
                  verticalSpaceMedium,
                  TextLink(
                    kfNotHaveAccount,
                    onPressed: () {
                      model.navigateToSignUp();
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
