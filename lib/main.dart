import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth/src/presentation/blocs/firebase_auth_app_observer.dart';
import 'package:firebaseauth/src/presentation/firebase_auth_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/di/get_it.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();

  Bloc.observer = FirebaseAuthAppObserver();

  runApp(const FirebaseAuthApp());
}
