import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  static Future checkConnexion(BuildContext context) async {
    bool hasInternet = false;
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      hasInternet = false;
    } else {
      hasInternet = true;
    }
    if (hasInternet == false) {
      const message = 'You have no internet check your connexion';
      final color = Colors.red;
      Utils.showTopSnackBar(context, message, color);
    }
  }

  static void showTopSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) =>
      showSimpleNotification(
        const Text('Internet Connectivity Update'),
        subtitle: Text(message),
        background: color,
        duration: const Duration(seconds: 5),
      );
}
