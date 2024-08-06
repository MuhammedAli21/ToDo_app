
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../data_classes/app_colors.dart';
import '../../provider/app_config_provider.dart';


class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});


  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.selectedTheme(ThemeMode.dark);
            },
            child: provider.isDarkmode() ?
            selectedLanguage(AppLocalizations.of(context)!.dark) :
            unSelectedLanguage(AppLocalizations.of(context)!.dark),
          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: () {
              provider.selectedTheme(ThemeMode.light);
            },
            child:provider.appTheme == ThemeMode.light ?
            selectedLanguage(AppLocalizations.of(context)!.light) :
            unSelectedLanguage(AppLocalizations.of(context)!.light),
          )
        ],
      ),
    );
  }

  Widget selectedLanguage(text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600
          ),),
        Icon(Icons.check,
          size: 30,
          color: AppColors.blueColor,),
      ],
    );
  }
  Widget unSelectedLanguage(text){
    return  Row(
      children: [
        Text(text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor
          ),)
      ],
    );
  }
}
