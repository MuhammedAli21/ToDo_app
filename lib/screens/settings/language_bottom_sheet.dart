import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data_classes/app_colors.dart';

import '../../provider/app_config_provider.dart';


class LanguageBottomSheet extends StatefulWidget {

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);


    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.selectedLanguage('en');
            },
            child: provider.appLanguage == 'en' ?
              selectedLanguage(AppLocalizations.of(context)!.english) :
              unSelectedLanguage(AppLocalizations.of(context)!.english),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: () {
              provider.selectedLanguage('ar');
            },
            child:provider.appLanguage == 'ar' ?
            selectedLanguage(AppLocalizations.of(context)!.arabic) :
            unSelectedLanguage(AppLocalizations.of(context)!.arabic),
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
