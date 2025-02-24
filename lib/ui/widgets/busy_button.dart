import 'package:flutter/material.dart';
import 'package:school_app/ui/shared/shared_styles.dart';
import 'package:school_app/utils/languages_and_localization/app_localizations.dart';

/// A button that shows a busy indicator in place of title
class BusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;

  const BusyButton({@required this.title,
    this.busy = false,
    @required this.onPressed,
    this.enabled = true});

  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: InkWell(
        child: AnimatedContainer(
          height: widget.busy ? 40 : null,
          width: widget.busy ? 40 : null,
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16),
          decoration: BoxDecoration(
            color: widget.enabled ? Theme
                .of(context)
                .primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: !widget.busy
              ? Text(
            AppLocalizations.of(context)
                .translate(widget.title),
            style: buttonTitleTextStyle,
          )
              : CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
      ),
    );
  }
}
