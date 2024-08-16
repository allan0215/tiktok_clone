import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  ref.watch(authState);
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      // TODO: 이해 안 됨;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeUrl &&
            state.matchedLocation != LoginScreen.routeURL) return SignUpScreen.routeUrl;
      }
      return null;
    },
    routes: [
      GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeUrl,
          builder: (context, state) => const SignUpScreen() //VideoRecordingScreen(),
          ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: InterestScreen.routeName,
        path: InterestScreen.routeURL,
        builder: (context, state) => const InterestScreen(),
      ),
      GoRoute(
        name: MainNavigation.routeName,
        path: "/:tab(home|discover|inbox|profile)",
        builder: (context, state) {
          final String tab = state.pathParameters["tab"]!;
          return MainNavigation(tab: tab);
        },
      ),
      GoRoute(
        path: ActivityScreen.routeURL,
        name: ActivityScreen.routeName,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        name: ChatsScreen.routeName,
        path: ChatsScreen.routeURL,
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            path: ChatDetailScreen.routeURL,
            name: ChatDetailScreen.routeName,
            builder: (context, state) {
              final id = state.pathParameters["chatId"]!;
              return ChatDetailScreen(
                chatId: id,
              );
            },
          )
        ],
      ),
      GoRoute(
          path: VideoRecordingScreen.routeURL,
          name: VideoRecordingScreen.routeName,
          pageBuilder: (context, state) => CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 200),
                child: const VideoRecordingScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  final position = Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: position,
                    child: child,
                  );
                },
              ))
    ],
  );
});
