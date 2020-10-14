import 'package:flutter/material.dart';
import 'package:school_app/models/claim.dart';
import 'package:school_app/ui/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:school_app/viewmodels/send_claim_view_model.dart';

class CreateClaimView extends StatelessWidget {
  final claimTitleController = TextEditingController();
  final claimController = TextEditingController();
  final Claim edittingClaim;

  CreateClaimView({Key key, this.edittingClaim}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateClaimViewModel>.reactive(
      viewModelBuilder: () => CreateClaimViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        claimController.text = edittingClaim?.claim ?? '';

        model.setEdittingClaim(edittingClaim);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
            onPressed: () {
              if (!model.busy) {
                model.addClaim(claimTitleController.text, claimController.text);
              }
            },
            backgroundColor:
            !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Send claim',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                Text('Claim'),
                verticalSpaceSmall,
                GestureDetector(
                  // When we tap we call selectImage
                  onTap: () => model.selectImage(),
                  child: Container(
                    child: Row(
                      children: [
                        TextField(
                          controller: claimTitleController,

                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          controller: claimController,

                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                    child: Text("Send",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                    onPressed: (){
                      model.addClaim( claimTitleController.text, claimController.text);
                    })
              ],
            ),
          )),
    );
  }
}
