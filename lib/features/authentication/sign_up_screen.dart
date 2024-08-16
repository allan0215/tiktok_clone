import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends ConsumerWidget {
  static const String routeUrl = "/";
  static const String routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(Localizations.localeOf(context));
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle("TikTok", DateTime.now()),
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    S.of(context).signUpSubTitle(1),
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: isDarkMode(context) ? Colors.grey.shade600 : Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: AuthButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.user,
                          ),
                          text: S.of(context).emailPasswordButton),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: () => ref.read(socialAuthProvider.notifier).githubSignIn(),
                      child: const AuthButton(
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                        ),
                        text: "Continue with Git Hub",
                      ),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: AuthButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.user,
                                ),
                                text: S.of(context).emailPasswordButton),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => ref.read(socialAuthProvider.notifier).githubSignIn(),
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.github,
                              ),
                              text: "Continue with Git Hub",
                            ),
                          ),
                        ),
                      ],
                    )
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
                Text(S.of(context).alreadyHaveAnAccount),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    S.of(context).logIn("female"),
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
      },
    );
  }
}
