import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:device_apps/device_apps.dart';

Future<String> getMXVersion() async {
  String package;

  try {
    if (await DeviceApps.isAppInstalled('com.mxtech.videoplayer.ad'))
      package = 'com.mxtech.videoplay.ad';
  } catch (_) {
    // User do not have MX Player free installed
  }

  try {
    if (await DeviceApps.isAppInstalled('com.mxtech.videoplayer.pro'))
      package = 'com.mxtech.videoplayer.pro';
  } catch (_) {
    // User do not have MX Player pro installed
  }

  return package;
}

void openMXPlayer(File movieFile) async {
  final String package = await getMXVersion();

  if (package != null) {
    AndroidIntent mxintent = AndroidIntent(
      action: 'action_view',
      package: package,
      data: Uri.encodeFull('content://${movieFile.path}'),
    );

    await mxintent.launch();
  }
}
