import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';
import 'package:todo_app/screens/settings/language_bottom_sheet.dart';
import 'package:todo_app/screens/settings/theme_bottom_sheet.dart';

import '../../provider/app_config_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "Settings_screen";

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.titleMedium,),
          InkWell(
            onTap: (){
              ShowLanguageBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: provider.isDarkmode()?
                    AppColors.blackDarkColor:
                    AppColors.whiteColor,
                border: Border.all(
                  color: AppColors.blueColor,
                  width: 2,
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == 'en' ?
                    AppLocalizations.of(context)!.english:
                    AppLocalizations.of(context)!.arabic,

                  style: Theme.of(context).textTheme.bodySmall,),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          Text(AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleMedium,),
          InkWell(
            onTap: () {
              ShowThemeBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: provider.isDarkmode()?
                      AppColors.blackDarkColor:
                      AppColors.whiteColor,
                  border: Border.all(
                    color: AppColors.blueColor,
                    width: 2,
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.isDarkmode() ?
                  AppLocalizations.of(context)!.dark:
                    AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.bodySmall,),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  void ShowLanguageBottomSheet() {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
        backgroundColor: AppColors.blackDarkColor ,
        context: context,
        builder: (context) => const Wrap(children:[LanguageBottomSheet()])
    );
  }

  void ShowThemeBottomSheet() {
    showModalBottomSheet(
      backgroundColor: AppColors.blackDarkColor,
      context: context,
      builder: (context) => const Wrap(children: [ThemeBottomSheet(),],)
    );
  }
}
