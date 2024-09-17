// ignore_for_file: unused_local_variable, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luminious/constants/constraint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeProvider( {required this.isLightTheme});


  getCurrentStatusNavigationBarColor(){
    if(isLightTheme){
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,

      ));
    }else{
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.navColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        ));
    }
  }
  
   toogleThemeData()  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isLightTheme) {
      sharedPreferences.setBool(Spref.isLight, false);
      isLightTheme = !isLightTheme;
      notifyListeners();    
    }else{
       sharedPreferences.setBool(Spref.isLight, true);
      isLightTheme = !isLightTheme;
      notifyListeners(); 
    }
    
  getCurrentStatusNavigationBarColor();
    notifyListeners();
  
    
  }
   


  ThemeData themeData(){
    return ThemeData(
      brightness: isLightTheme? Brightness.light:Brightness.dark,
      scaffoldBackgroundColor: isLightTheme? AppColors.yellow : AppColors.black,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.stickNoBills(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: isLightTheme? AppColors.black : AppColors.orange,
        ),
        headlineMedium: GoogleFonts.robotoCondensed(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        height: 0.98
        ),
        headlineSmall:  GoogleFonts.robotoCondensed(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        height: 1
        
        ),
        displayLarge:  TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          height: 1.5
        ),
      )
    );
  }


ThemeMode themeMode(){
  return ThemeMode(
    gradientColors: isLightTheme?
    [AppColors.yellow, AppColors.yellowDark] : [AppColors.black , AppColors.black],
    switchColor: isLightTheme? AppColors.black : AppColors.orange,
    thumbColor:  isLightTheme? AppColors.orange : AppColors.black,
    switchBgColor: isLightTheme? AppColors.black.withOpacity(.1) : AppColors.darkgrey.withOpacity(.3)
    
  );
}
}


class ThemeMode{
  List<Color>? gradientColors;
  Color? switchColor;
  Color? switchBgColor;
  Color? thumbColor;
  
  


ThemeMode({
  this.switchColor,
  this.switchBgColor,
  this.thumbColor, this.gradientColors, 
});

}