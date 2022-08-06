import 'package:firebaseauth/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:firebaseauth/src/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController,
      _emailController,
      _passwordController;

  String get name => _nameController.text;
  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full name'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<AuthBloc>(context).add(
                          RegisterBtnPressed(
                              name: name, email: email, password: password),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
