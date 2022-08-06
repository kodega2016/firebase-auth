import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text('Khadga Bahadur Shrestha'),
              accountEmail: Text('khadgalovecoding2016@gmail.com'),
            ),
            ListTile(
              title: Text('Sign Out'),
              trailing: Icon(Icons.exit_to_app),
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
        padding: const EdgeInsets.all(8.0),
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
            leading: CircleAvatar(
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
    );
  }
}
