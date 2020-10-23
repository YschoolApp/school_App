import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropDownMenu extends StatelessWidget {
  final List<dynamic> list;
  final String attributeKey;
  final String labelText;
  final bool isExpanded;
  final String hintText;

  // final String value;

  const DropDownMenu({
    this.list,
    this.attributeKey,
    this.labelText,
    this.hintText,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: FormBuilderDropdown(
        isExpanded: isExpanded,
        attribute: attributeKey,
        decoration: InputDecoration(
          //labelText: labelText,
//                labelStyle: kAppBarTextStyle,
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.grey, //Theme.of(context).primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.grey, //Theme.of(context).primaryColor,
              //width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        // initialValue: 'Male',
        hint: Text(hintText),
        validators: [FormBuilderValidators.required()],
        items: list
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
    );
  }
}
