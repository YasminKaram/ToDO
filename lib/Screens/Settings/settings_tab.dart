import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/MyProvider.dart';
import 'package:todo/Screens/Settings/bottomSheets/ShowBottomSheetLanguage.dart';
import 'package:todo/Screens/Settings/bottomSheets/ShowBottomSheetTheming.dart';
import 'package:todo/Shared/style/Colors.dart';

class SettingsTab extends StatefulWidget {
  static const String routeName = "settings";

  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
          ),
          InkWell(
            onTap: () {
              showLanguageSheet();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pro.Language == "en"
                      ? AppLocalizations.of(context)!.langENg
                      : AppLocalizations.of(context)!.langArb,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(color: primaryColor, width: 2)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.themeing,
          ),
          InkWell(
            onTap: () {
              showThemingSheet();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pro.mode==ThemeMode.light
                      ? AppLocalizations.of(context)!.light
                      : AppLocalizations.of(context)!.dark,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(color: primaryColor, width: 2)),
            ),
          ),
        ],
      ),
    );
  }

  showLanguageSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      builder: (context) {
        return ShowBottomSheetLanguage();
      },
    );
  }

  showThemingSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      builder: (context) {
        return ShowBottomSheetTheming();
      },
    );
  }
}
