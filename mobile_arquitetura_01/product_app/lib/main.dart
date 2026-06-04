import 'package:flutter/material.dart';

import 'package:product_app/screens/product_list_screen.dart';
import 'package:product_app/screens/login_screen.dart';
import 'package:product_app/session/session_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produtos com Autenticacao',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SessionGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SessionGate extends StatefulWidget {
  const SessionGate({super.key});

  @override
  State<SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<SessionGate> {
  late final Future<void> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = SessionController.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return SessionController.instance.isLoggedIn
            ? const ProductListScreen()
            : const LoginScreen();
      },
    );
  }
}
