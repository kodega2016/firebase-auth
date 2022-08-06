import 'package:firebaseauth/src/di/get_it.dart';
import 'package:firebaseauth/src/presentation/auth/auth_screen.dart';
import 'package:firebaseauth/src/presentation/blocs/app/app_bloc.dart';
import 'package:firebaseauth/src/presentation/blocs/login/login_bloc.dart';
import 'package:firebaseauth/src/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseAuthApp extends StatefulWidget {
  const FirebaseAuthApp({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthApp> createState() => _FirebaseAuthAppState();
}

class _FirebaseAuthAppState extends State<FirebaseAuthApp> {
  late LoginBloc loginBloc;
  late AppBloc appBloc;

  @override
  void initState() {
    loginBloc = getIt<LoginBloc>();
    appBloc = getIt<AppBloc>();
    appBloc.add(AppLaunched());
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.close();
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: appBloc,
        ),
        BlocProvider.value(
          value: loginBloc,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.brown,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.brown),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        ),
        home: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.authState == AuthState.authenticated) {
              return const HomeScreen();
            }
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
