import 'package:firebaseauth/src/di/get_it.dart';
import 'package:firebaseauth/src/presentation/auth/auth_screen.dart';
import 'package:firebaseauth/src/presentation/blocs/app/app_bloc.dart';
import 'package:firebaseauth/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebaseauth/src/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseAuthApp extends StatefulWidget {
  const FirebaseAuthApp({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthApp> createState() => _FirebaseAuthAppState();
}

class _FirebaseAuthAppState extends State<FirebaseAuthApp> {
  late AuthBloc authBloc;
  late AppBloc appBloc;

  @override
  void initState() {
    authBloc = getIt<AuthBloc>();
    appBloc = authBloc.appBloc;
    appBloc.add(AppLaunched());
    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
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
          value: authBloc,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme: const AppBarTheme(elevation: 1),
        ),
        home: BlocBuilder<AppBloc, AppState>(
          // buildWhen: (previous, current) =>
          //     current.authState == AuthenticationState.authenticated,
          builder: (context, state) {
            if (state.authState == AuthenticationState.authenticated) {
              return const HomeScreen();
            }
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
