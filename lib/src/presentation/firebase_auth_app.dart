import 'package:firebaseauth/src/di/get_it.dart';
import 'package:firebaseauth/src/presentation/auth/auth_screen.dart';
import 'package:firebaseauth/src/presentation/blocs/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseAuthApp extends StatefulWidget {
  const FirebaseAuthApp({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthApp> createState() => _FirebaseAuthAppState();
}

class _FirebaseAuthAppState extends State<FirebaseAuthApp> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = getIt<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.brown,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.brown),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        ),
        home: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
