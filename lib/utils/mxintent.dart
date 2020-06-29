import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:device_apps/device_apps.dart';

void openMXPlayer(File movieFile, String subFile) async {
  String package;
  try {
    if (await DeviceApps.isAppInstalled('com.mxtech.videoplayer.pro'))
      package = 'com.mxtech.videoplayer.pro';
  } catch (_) {}
  try {
    if (await DeviceApps.isAppInstalled('com.mxtech.videoplayer.ad'))
      package = 'com.mxtech.videoplay.ad';
  } catch (_) {}

  if (package != null) {
    AndroidIntent mxintent = AndroidIntent(
      action: 'action_view',
      package: package,
      data: Uri.encodeFull('content://${movieFile.path}'),
    );

    await mxintent.launch();
  }
}
