// ignore_for_file: use_build_context_synchronously

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late UserRepository userRepository;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString('token');

    if (token != null) {
      GoogleSignInAccount? account =
          await _googleSignIn.signInSilently(suppressErrors: false);

      if (account != null) {
        userRepository.usuarioFromAccount(account);
        GoRouter.of(context).go('/home');
      }
    }
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        userRepository.usuarioFromAccount(account);
        await prefs!
            .setString('token', (await account.authentication).accessToken!);
        GoRouter.of(context).go('/home');
      }
      // else {
      //   GoRouter.of(context).go('/agenda');
      // }
    } catch (error) {
      _dialogBuilder(context, error.toString());
      userRepository.usuario.nome = error.toString();
      GoRouter.of(context).go('/mensagemparoco');
    }
  }

  Future<void> _dialogBuilder(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: GestureDetector(
          onTap: _handleSignIn,
          child: AvatarGlow(
            startDelay: const Duration(milliseconds: 100),
            glowColor: Colors.white,
            glowShape: BoxShape.circle,
            animate: true,
            curve: Curves.fastOutSlowIn,
            child: const Material(
              elevation: 8.0,
              shape: CircleBorder(),
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/google.png'),
                radius: 50.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
