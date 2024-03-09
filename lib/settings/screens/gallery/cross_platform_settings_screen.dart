import 'package:formfillpro/settings/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:formfillpro/settings/flutter_settings_ui.dart';

class CrossPlatformSettingsScreen extends StatefulWidget {
  const CrossPlatformSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CrossPlatformSettingsScreen> createState() =>
      _CrossPlatformSettingsScreenState();
}

class _CrossPlatformSettingsScreenState
    extends State<CrossPlatformSettingsScreen> {
  bool useCustomTheme = false;

  final platformsMap = <DevicePlatform, String>{
    DevicePlatform.device: 'Default',
    DevicePlatform.android: 'Android',
    DevicePlatform.iOS: 'iOS',
    DevicePlatform.web: 'Web',
    DevicePlatform.fuchsia: 'Fuchsia',
    DevicePlatform.linux: 'Linux',
    DevicePlatform.macOS: 'MacOS',
    DevicePlatform.windows: 'Windows',
  };
  DevicePlatform selectedPlatform = DevicePlatform.device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        platform: selectedPlatform,
        lightTheme: !useCustomTheme
            ? null
            : const SettingsThemeData(
                dividerColor: Colors.red,
                tileDescriptionTextColor: Colors.yellow,
                leadingIconsColor: Colors.pink,
                settingsListBackground: Colors.white,
                settingsSectionBackground: Colors.green,
                settingsTileTextColor: Colors.tealAccent,
                tileHighlightColor: Colors.blue,
                titleTextColor: Colors.cyan,
                trailingTextColor: Colors.deepOrangeAccent,
              ),
        darkTheme: !useCustomTheme
            ? null
            : const SettingsThemeData(
                dividerColor: Colors.pink,
                tileDescriptionTextColor: Colors.blue,
                leadingIconsColor: Colors.red,
                settingsListBackground: Colors.grey,
                settingsSectionBackground: Colors.tealAccent,
                settingsTileTextColor: Colors.green,
                tileHighlightColor: Colors.yellow,
                titleTextColor: Colors.cyan,
                trailingTextColor: Colors.orange,
              ),
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.cloud_outlined),
                title: const Text('Environment'),
                value: const Text('Production'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.devices_other),
                title: const Text('Platform'),
                onPressed: (context) async {
                  final platform = await Navigation.navigateTo<DevicePlatform>(
                    context: context,
                    style: NavigationRouteStyle.material,
                    screen: PlatformPickerScreen(
                      platform: selectedPlatform,
                      platforms: platformsMap,
                    ),
                  );

                  if (platform != null) {
                    setState(() {
                      selectedPlatform = platform;
                    });
                  }
                },
                value: Text(platformsMap[selectedPlatform]!),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    useCustomTheme = value;
                  });
                },
                initialValue: useCustomTheme,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.phone),
                title: const Text('Phone number'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.mail),
                title: const Text('Email'),
                enabled: false,
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.logout),
                title: const Text('Sign out'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Security'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: const Icon(Icons.phonelink_lock),
                title: const Text('Lock app in background'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: const Icon(Icons.fingerprint),
                title: const Text('Use fingerprint'),
                description: const Text(
                  'Allow application to access stored fingerprint IDs',
                ),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: const Icon(Icons.lock),
                title: const Text('Change password'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: const Icon(Icons.notifications_active),
                title: const Text('Enable notifications'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Misc'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.description),
                title: const Text('Terms of Service'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.collections_bookmark),
                title: const Text('Open source license'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlatformPickerScreen extends StatelessWidget {
  const PlatformPickerScreen({
    Key? key,
    required this.platform,
    required this.platforms,
  }) : super(key: key);

  final DevicePlatform platform;
  final Map<DevicePlatform, String> platforms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platforms')),
      body: SettingsList(
        platform: platform,
        sections: [
          SettingsSection(
            title: const Text('Select the platform you want'),
            tiles: platforms.keys.map((e) {
              final platform = platforms[e];

              return SettingsTile(
                title: Text(platform!),
                onPressed: (_) {
                  Navigator.of(context).pop(e);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
