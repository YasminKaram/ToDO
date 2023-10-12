import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/MyProvider.dart';
import 'package:todo/Shared/style/Colors.dart';
class ShowBottomSheetTheming extends StatelessWidget {
  const ShowBottomSheetTheming({super.key});

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  pro.changeTheming(ThemeMode.light);
                  Navigator.pop(context);

                },
                child: Row(
                  children: [
                    Text(AppLocalizations.of(context)!.light,
                        style: Theme.of(context).textTheme.bodySmall),
                    Spacer(),
                    pro.mode==ThemeMode.light?
                    Icon(
                      Icons.check,
                      color: primaryColor,
                    ):SizedBox.shrink()
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  pro.changeTheming(ThemeMode.dark);
                  Navigator.pop(context);

                },
                child: Row(
                  children: [
                    Text(AppLocalizations.of(context)!.dark,
                        style: Theme.of(context).textTheme.bodySmall),
                    Spacer(),
                    pro.mode==ThemeMode.dark ?
                    Icon(
                      Icons.check,
                      color: primaryColor,
                    ):SizedBox.shrink()
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
