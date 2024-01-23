// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';
import 'package:santa_barbara/modules/home/home.view.dart';
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
        //MaterialPageRoute(builder: (context) => const HomeView());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      }
    }
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Save token
        userRepository.usuarioFromAccount(account);
        await prefs!
            .setString('token', (await account.authentication).accessToken!);

        // Navigate to home screen
        //MaterialPageRoute(builder: (context) => const HomeView());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      }
    } catch (error) {
      print('ERRRRRROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
