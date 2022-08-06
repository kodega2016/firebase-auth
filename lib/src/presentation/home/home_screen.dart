import 'package:firebaseauth/src/presentation/auth/auth_screen.dart';
import 'package:firebaseauth/src/presentation/blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state.authState == AuthenticationState.authenticated) {
                  return UserAccountsDrawerHeader(
                    accountName: Text('${state.user?.name}'),
                    accountEmail: Text('${state.user?.email}'),
                  );
                }

                return Container();
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () async {
                context.read<AppBloc>().add(LogoutBtnPressed());
              },
            ),
            BlocListener<AppBloc, AppState>(
              listenWhen: (prev, current) =>
                  current.authState == AuthenticationState.unauthenticated,
              listener: (context, state) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                );
              },
              child: Container(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return const TodoItem();
          },
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ListTile(
            title: Text('Learn Basic of Rust'),
            subtitle: Text('Explore basic program structure of rustlang'),
          ),
        ],
      ),
    );
  }
}
