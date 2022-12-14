import 'package:firebaseauth/src/presentation/auth/signup_screen.dart';
import 'package:firebaseauth/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebaseauth/src/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _emailController, _passwordController;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AuthBloc, AuthState>(
                    // buildWhen: (prev, current) => current is LoginLoading,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox();
                    },
                    listenWhen: (prev, current) => current is AuthError,
                    listener: (context, state) {
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    child: Container(),
                    listenWhen: (prev, current) => current is AuthSuccess,
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginBtnPressed(email: email, password: password),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Don\'t have an account?Register',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
