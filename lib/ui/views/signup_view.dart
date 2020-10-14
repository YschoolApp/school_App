import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/models/user_model.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:school_app/ui/widgets/busy_button.dart';
import 'package:school_app/ui/widgets/expansion_list.dart';
import 'package:school_app/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:school_app/ui/widgets/logo_icon.dart';
import 'package:school_app/viewmodels/signup_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                verticalSpaceLarge,
                LogoIcon(
                  screenName: kfSignUp,
                  tag: 'logo1',
                  assetPath: 'assets/images/signup.svg',
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: kfName,
                  controller: fullNameController,
                  textInputType: TextInputType.name,
                ),
                // verticalSpaceSmall,
                InputField(
                  placeholder: kfEmail,
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                // verticalSpaceSmall,
                InputField(
                  placeholder: kfPassword,
                  password: true,
                  controller: passwordController,
                  additionalNote: 'Password has to be a minimum of 6 characters.',
                ),
                InputField(
                  placeholder: kfPhoneNum,
                  controller: phoneController,
                  textInputType: TextInputType.phone,
                ),
                InputField(
                  placeholder: kfAddress,
                  controller: addressController,

                ),
                verticalSpaceSmall,
                ExpansionList<String>(
                    items: [kfTeacher,kfParent, kfStudent],
                    title: model.selectedRole,
                    onItemSelected: model.setSelectedRole),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BusyButton(
                      title: kfSignUp,
                      busy: model.busy,
                      onPressed: () {
                        model.signUp(
                          newUser: MyUser(
                            userEmail: emailController.text,
                            userFullName: fullNameController.text,
                            userAddress: addressController.text,
                            userPhone: phoneController.text,
                            userRole: model.selectedRole,
                          ),
                          password: passwordController.text,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
