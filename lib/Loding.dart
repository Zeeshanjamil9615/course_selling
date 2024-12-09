import 'package:course_selling/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast fToast = FToast();

showLoader(BuildContext dialogContext, message) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(1),
          child: CircularProgressIndicator(
            backgroundColor: lightColor,
            color: primaryColor,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(7),
          child: Text(
            message,
            maxLines: 5,
            style: const TextStyle(fontSize: 14, fontFamily: 'ns'),
          ),
        )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: dialogContext,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}

unFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

pop(BuildContext context) {
  Navigator.pop(context);
}

Pop(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

showToast(BuildContext context, {int duration = 3, String msg = ''}) {
  fToast.init(context);
  fToast.showToast(
    toastDuration: Duration(seconds: duration),
    gravity: ToastGravity.BOTTOM,
    child: Container(
      padding: const EdgeInsets.only(left: 13, top: 20, right: 5, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image.asset('assets/images/t_logo.png', height: 15),
          // const SizedBox(width: 13),
          Expanded(
            child: Text(
              msg,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontFamily: 'cabin bold',
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onTap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'cabin bold',
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'cabin reg',
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'cabin bold',
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'cabin bold',
              ),
            ),
            onPressed: () {
              pop(context);
              onTap();
            },
          ),
        ],
      );
    },
  );
}
