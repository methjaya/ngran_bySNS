import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase_test/admin/admin_home_page.dart';
import 'package:flutter_firebase_test/admin/user_data.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';

class VerifyUserEmail extends StatefulWidget {
  const VerifyUserEmail({super.key});

  @override
  State<VerifyUserEmail> createState() => _VerifyUserEmailState();
}

class _VerifyUserEmailState extends State<VerifyUserEmail> {
  bool isVerified = false;
  bool canResend = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendEmailVerification();

      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        isVerifiedEmail();
        print("hello");
      });
    }
  }

  Future isVerifiedEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) {
      timer!.cancel();
    }
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResend = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResend = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to Send Email Verification'),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isVerified
      ? (UserData.userRole == "student"
          ? const HomePage()
          : const HomePageAdmin())
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify Email"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A Verification Email has been sent to your email",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        sendEmailVerification();
                      },
                      icon: const Icon(Icons.email, size: 34),
                      label: const Text(
                        "Resend Email",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextButton(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ),
          ),
        );
}
