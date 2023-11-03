import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/app/settings/presentation/widgets/settings_item.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/radios/radio_option.dart';
import 'package:habit_go/core/widgets/switches/switch_option.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  bool themeChanged(SettingsEntity previous, SettingsEntity current) =>
      previous.themeMode != current.themeMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsEntity>(
      buildWhen: themeChanged,
      builder: (context, settings) {
        return Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Settings',
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'App theme',
                        style: context.text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RadioOption(
                        options: const {
                          'Light': AppTheme.light,
                          'Dark': AppTheme.dark,
                          'System': AppTheme.system,
                        },
                        selectedOption: settings.themeMode,
                        onChanged: (theme) {
                          context.read<SettingsCubit>().updateTheme(theme);
                        },
                      ),
                      const SizedBox(height: 10),
                      SwitchOption(
                        id: '',
                        title: 'Enable animations',
                        active: settings.appAnimations,
                        onChanged: (value) {
                          context
                              .read<SettingsCubit>()
                              .updateAppAnimations(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      SwitchOption(
                        id: '',
                        title: 'Enable notifications',
                        active: settings.notifications,
                        onChanged: (value) {
                          context
                              .read<SettingsCubit>()
                              .updateNotifications(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      SettingsItem(
                        title: 'About HabitGo',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
