import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final int index;

  const CardTemplate(
      {Key key, this.iconData, this.text, this.onTap, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 5.0,
                ),
              ],
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Icon(
              iconData,
              size: 40,
              color: Theme.of(context).cardColor,
            ),
          ),
          // Spacer(),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
