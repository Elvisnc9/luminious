import 'package:flutter/material.dart';
import 'package:luminious/constants/constraint.dart';
import 'package:luminious/constants/theme.dart';
import 'package:luminious/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLightTheme = prefs.getBool(Spref.isLight) ?? true;

  runApp( AppStart( isLightTheme: isLightTheme));
}

class AppStart extends StatelessWidget {
  const AppStart({super.key, required this.isLightTheme});
  final bool isLightTheme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create:(_) => ThemeProvider(isLightTheme: isLightTheme) )],
      child: MyApp(),
    );
  }  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'luminious',
      theme:themeProvider.themeData(),
      home: const Screen()
    );
  }
}
