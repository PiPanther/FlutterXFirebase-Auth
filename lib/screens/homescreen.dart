import 'package:card_app/components/buttons.dart';
import 'package:card_app/components/myTextField.dart';
import 'package:card_app/components/squareTile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void wrongEmail() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Wrong Email'),
            );
          });
    }

    void wrongPassword() {
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Wrong Password'),
            );
          });
    }

    void signUserIn() async {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') { 
          print('NO EMAIL GIVEN');
          wrongEmail();
        } else if (e.code == 'wrong-password') {
          print('WRONG PASSWORD');
          wrongPassword();
        } else {
          // Handle other exceptions
        }
      }

      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Icon(
                Icons.lock,
                size: 150,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Welcome back, you\'ve been missed !',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: userController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue.shade500, fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                onTap: signUserIn,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Or continue with'),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  squareTile(imagePath: 'lib/assets/google.png'),
                  SizedBox(
                    width: 20,
                  ),
                  squareTile(imagePath: 'lib/assets/apple.png'),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Register Now',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
