import 'package:flutter/material.dart';
import 'package:todo/Shared/style/Colors.dart';
import 'package:todo/Shared/style/MyThemedata.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(

            children: [
              Container(
                height: 80,
                width: 3,
                decoration: BoxDecoration(
                    color: primaryColor, borderRadius: BorderRadius.circular(18)),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.taskTitle,style:Theme.of(context).textTheme.bodySmall),
                  Text(AppLocalizations.of(context)!.taskDescription,style:Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18)),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.check),
                color: primaryColor,
                style:ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))


              )
            ],
          ),
        ),
      ),
    );
  }
}
