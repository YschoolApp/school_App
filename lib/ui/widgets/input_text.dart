import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';

class InputTextForm extends StatefulWidget {
  final String kfHintText;
  final String kfLabelText;
  final String attributeKey;
  final String initialValue;
  final int minLine;
  final bool autoFocus;
  final TextEditingController textEditingController;

  const InputTextForm({
    this.attributeKey = 'atk',
    this.kfHintText,
    this.autoFocus = false,
    this.kfLabelText,
    this.textEditingController,
    this.initialValue = '',
    this.minLine,
  });

  @override
  _InputTextFormState createState() => _InputTextFormState();
}

class _InputTextFormState extends State<InputTextForm> {
  String text = '';
  bool isRTL = false;

  @override
  void initState() {
    super.initState();
    widget.textEditingController?.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: widget.attributeKey,
      controller: widget.textEditingController,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).translate(widget.kfHintText),
        labelText: AppLocalizations.of(context).translate(widget.kfLabelText),
//          labelStyle: kAppBarTextStyle,
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      minLines: widget.minLine,
      maxLines: widget.minLine == null ? null : 2000,
      validators: [
        FormBuilderValidators.required(errorText: kfRequiredField),
      ],
    );
  }
}
