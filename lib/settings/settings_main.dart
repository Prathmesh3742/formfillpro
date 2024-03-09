import 'package:device_preview/device_preview.dart';
import 'package:formfillpro/settings/screens/gallery/cross_platform_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Set to `true` to see the full possibilities of the iOS Developer Screen
const bool runCupertinoApp = false;

class SettingsMain extends StatelessWidget {
  const SettingsMain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (runCupertinoApp) {
      return CupertinoApp(
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Settings UI Demo',
        home: const CrossPlatformSettingsScreen(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(
            cupertinoOverrideTheme: const CupertinoThemeData(
                barBackgroundColor: Color(0xFF1b1b1b),
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(primaryColor: Colors.white)),
            brightness: Brightness.dark),
        title: 'Settings UI Demo',
        home: const CrossPlatformSettingsScreen(),
      );
    }
  }
}
