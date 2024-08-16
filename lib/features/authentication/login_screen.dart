import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = "logIn";
  static const String routeURL = "/logIn";
  const LoginScreen({super.key});

  void onSignUpTap(BuildContext context) {
    context.go(SignUpScreen.routeName);
  }

  void _onEamilLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginFormScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Log in to TickTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEamilLoginTap(context),
                child: const AuthButton(
                    icon: FaIcon(
                      FontAwesomeIcons.user,
                    ),
                    text: "Use email & password"),
              ),
              Gaps.v16,
              GestureDetector(
                onTap: () => ref.read(socialAuthProvider.notifier).githubSignIn(),
                child: const AuthButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                    ),
                    text: "Continue with Git Hub"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size28,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Dont' have an account?"),
            Gaps.h5,
            GestureDetector(
              onTap: () => onSignUpTap(context),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
