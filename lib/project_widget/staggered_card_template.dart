import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final int index;

  const CardTemplate({Key key, this.iconData, this.text, this.onTap, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.shade500,
      hoverColor: Colors.black54,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(5.0, 5.0),
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Icon(
                      iconData,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    )),
                Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}