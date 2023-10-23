import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Provider/MyProvider.dart';
import 'package:todo/Screens/Register/Register.dart';
import 'package:todo/Screens/Tasks/EditTask.dart';
import 'package:todo/Shared/style/MyThemedata.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/layout/homeLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/prefs_Helper.dart';
import 'package:todo/prefs_Helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefsHelper.prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//   دي معناها هتكون local مش هيرفعها ومش هنستخدم future مش هنحتاج
  //FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider()..init(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      locale: Locale(pro.Language),
      themeMode: pro.mode,
      initialRoute: pro.firebaseUser != null
          ? HomeLayout.routeName
          : RegisterScreen.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),
        EditTask.routeName: (context) => EditTask(),
      },
    );
  }
}
