import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevesomiy/app.dart';
import 'package:nevesomiy/app_wrapper.dart';



import 'presentation/bloc/simple_bloc_observer.dart';


Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
    Bloc.transformer = concurrent<dynamic>();    
    Bloc.observer = SimpleBlocObserver();
    runApp(const AppWrapper(child: App()));   
}

