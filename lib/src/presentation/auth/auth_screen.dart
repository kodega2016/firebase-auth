import 'package:firebaseauth/src/presentation/blocs/bloc/login_bloc.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to authentication app',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<LoginBloc, LoginState>(
              // buildWhen: (prev, current) => current is LoginLoading,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const LinearProgressIndicator();
                }
                return const SizedBox();
              },
              listenWhen: (prev, current) => current is LoginError,
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              child: Container(),
              listenWhen: (prev, current) => current is LoginSuccecss,
              listener: (context, state) {
                if (state is LoginSuccecss) {
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
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginBtnPressed(email: email, password: password),
                  );
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
