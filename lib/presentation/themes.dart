import 'package:flutter/material.dart';
import 'package:nevesomiy/presentation/styles/styles.dart';


mixin AppThemes {
  static ThemeData get ligthTheme => ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorStyles.pallete3,
        primary: ColorStyles.pallete1,
        secondary: ColorStyles.pallete2,
        tertiary: ColorStyles.pallete3
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorStyles.pallete1,
        titleTextStyle:  TextStyle(
          fontSize: 18,
          fontFamily: 'Pacifico',     
          color: ColorStyles.pallete3,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Pacifico',     
            color: ColorStyles.pallete1,
          )
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(ColorStyles.pallete3.withOpacity(0.9)),
          foregroundColor: WidgetStateProperty.all(ColorStyles.pallete3),
          overlayColor: WidgetStateProperty.all(ColorStyles.mainColorSplash),
          shadowColor:  WidgetStateProperty.all(ColorStyles.pallete1),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )
      ),      
      cardTheme: CardTheme(
        elevation: 2,
        shadowColor: ColorStyles.pallete1,
        surfaceTintColor: ColorStyles.pallete3,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorStyles.pallete3,
        elevation: 20
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),   
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.transparent,
        isDense: true,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: 'Pacifico',           
          color: ColorStyles.errorColor,
          fontStyle: FontStyle.normal,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Pacifico',           
          color: ColorStyles.hintTextFieldColor,
          fontStyle: FontStyle.normal,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Pacifico',           
          color: ColorStyles.pallete1,
          fontStyle: FontStyle.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.pallete1, width: 1),
        ),       
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.pallete1, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.errorColor, width: 1),
        ), 
      ),
      textTheme:  TextTheme(
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,  
          fontFamily: 'Pacifico',  
          color: Colors.black54,
          fontStyle: FontStyle.normal,
        ),
        titleSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,  
          fontFamily: 'Roboto',  
          color: Colors.black54,
          fontStyle: FontStyle.normal,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,    
          fontFamily: 'Roboto',  
          color: ColorStyles.pallete4,
          fontStyle: FontStyle.normal,
        ),
        bodyLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,    
          fontFamily: 'Pacifico',   //Pacifico
          color: Colors.black54,
          fontStyle: FontStyle.normal,
        ), 
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,    
          fontFamily: 'Pacifico',   //Pacifico
          color: Colors.black54,
          fontStyle: FontStyle.normal,
        ),            
      ),
  );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorStyles.pallete3,
        primary: ColorStyles.pallete1,
        secondary: ColorStyles.pallete2,
        tertiary: ColorStyles.pallete3
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorStyles.pallete1,
        titleTextStyle:  TextStyle(
          fontSize: 18,
          fontFamily: 'Pacifico',     
          color: ColorStyles.pallete3,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Pacifico',     
            color: ColorStyles.pallete1,
          )
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(ColorStyles.pallete3.withOpacity(0.9)),
          foregroundColor: WidgetStateProperty.all(ColorStyles.pallete3),
          overlayColor: WidgetStateProperty.all(ColorStyles.mainColorSplash),
          shadowColor:  WidgetStateProperty.all(ColorStyles.pallete1),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )
      ),      
      cardTheme: CardTheme(
        elevation: 2,
        shadowColor: ColorStyles.pallete1,
        surfaceTintColor: ColorStyles.pallete3,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorStyles.pallete3,
        elevation: 20
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),   
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.transparent,
        isDense: true,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: 'Pacifico',           
          color: ColorStyles.errorColor,
          fontStyle: FontStyle.normal,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Pacifico',           
          color: ColorStyles.hintTextFieldColor,
          fontStyle: FontStyle.normal,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Pacifico',           
          color: ColorStyles.pallete1,
          fontStyle: FontStyle.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.pallete1, width: 1),
        ),       
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.pallete1, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.horizontal(),
          borderSide: BorderSide(color: ColorStyles.errorColor, width: 1),
        ), 
      ),
      textTheme:  TextTheme(
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,  
          fontFamily: 'Pacifico',  
          color: Colors.blueGrey,
          fontStyle: FontStyle.normal,
        ),
        titleSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,  
          fontFamily: 'Roboto',  
          color: Colors.black54,
          fontStyle: FontStyle.normal,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,    
          fontFamily: 'Roboto',  
          color: ColorStyles.pallete4,
          fontStyle: FontStyle.normal,
        ),
        bodyLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,    
          fontFamily: 'Pacifico',   //Pacifico
          color: Colors.white54,
          fontStyle: FontStyle.normal,
        ), 
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,    
          fontFamily: 'Pacifico',   //Pacifico
          color: Colors.blueGrey,
          fontStyle: FontStyle.normal,
        ),            
      ),
  );
}
