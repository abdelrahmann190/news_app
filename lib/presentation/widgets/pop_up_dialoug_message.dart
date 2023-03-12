// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

class AlertDialogMessage extends StatefulWidget {
  String? titleText;
  String? contentText;
  bool dismissLoadingWidget;
  List<Widget>? actionsList;
  final bool isLoadingWidget;

  AlertDialogMessage({
    Key? key,
    this.titleText,
    this.contentText,
    this.actionsList,
    this.dismissLoadingWidget = false,
    required this.isLoadingWidget,
  }) : super(key: key);

  @override
  State<AlertDialogMessage> createState() => _AlertDialogMessageState();
}

class _AlertDialogMessageState extends State<AlertDialogMessage> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoadingWidget
        ? loadingWidgetAlertDialog()
        : errorMessageAlertDialog();
  }

  Widget loadingWidgetAlertDialog() {
    return AlertDialog(
      content: Container(
        width: 200,
        height: 240,
        padding: const EdgeInsets.all(50),
        child: const CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      actions: widget.dismissLoadingWidget
          ? [
              TextButton(
                onFocusChange: (dismissible) {
                  widget.dismissLoadingWidget = dismissible;
                  Navigator.pop(context);
                },
                child: Text(''),
                onPressed: () {},
              )
            ]
          : [],
    );
  }

  Widget errorMessageAlertDialog() {
    return AlertDialog(
      title: NormalText(
        text: widget.titleText ?? '',
      ),
      content: BoldText(
        text: widget.contentText ?? '',
        fontSize: 20,
      ),
      actions: widget.actionsList ??
          [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
    );
  }
}
