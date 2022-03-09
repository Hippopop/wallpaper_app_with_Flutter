import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_with_flutter/src/Controller/main_data_controller.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainDataFlower())
  ], child: MyApp(settingsController: settingsController)));
}
