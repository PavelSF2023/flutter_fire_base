import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Список дел'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text(
            'Main Screen',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/todo');
              },
              child: const Text('Перейти далее'))
        ],
      ),
    );
  }
}
