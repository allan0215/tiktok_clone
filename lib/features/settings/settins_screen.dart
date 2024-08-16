import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override // ConsumerWidget은 WidgetRef ref가 필요함.
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          // ValueListenableBuilder(
          //   valueListenable: videoConfig,
          //   builder: (context, value, child) => SwitchListTile.adaptive(
          //     value: value,
          //     onChanged: (value) {
          //       videoConfig.value = !videoConfig.value;
          //     },
          //     title: const Text("Mute Video"),
          //     subtitle: const Text("This widget is made by value listnebale builder"),
          //   ),
          // ),
          // ListenableBuilder(
          //   listenable: videoConfig,
          //   builder: (context, child) => SwitchListTile.adaptive(
          //     value: videoConfig.value,
          //     onChanged: (value) {
          //       videoConfig.value = !videoConfig.value;
          //     },
          //     title: const Text("Mute Video"),
          //     subtitle: const Text("This widget is made by listnebale builder"),
          //   ),
          // ),
          // AnimatedBuilder(
          //   // ChangeNotifier를 들을 때 사용되기도 함. but, 요즘은 ListenableBuilder가 사용된다고 함.
          //   animation: videoConfig,
          //   builder: (context, child) => SwitchListTile.adaptive(
          //     value: videoConfig.value,
          //     onChanged: (value) {
          //       videoConfig.value = !videoConfig.value;
          //     },
          //     title: const Text("Mute Video"),
          //     subtitle: const Text("This widget is made by animation builder"),
          //   ),
          // ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) {
              // 데이터가 아니라 메서드에 접근할 때에는 playbackConfigProvider.notifier 사용
              ref.read(playbackConfigProvider.notifier).setMuted(value);
            },
            title: const Text("Mute Video"),
            subtitle: const Text("Video will be muted by default."),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoPlay,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setAutoPlay(value);
            },
            title: const Text("Auto play"),
            subtitle: const Text("Video will start playing automatically."),
          ),
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) {},
            title: const Text("Enable notifications"),
            subtitle: const Text("They will be cute."),
          ),
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) {},
            title: const Text("Enable notifications"),
            subtitle: const Text("They will be cute."),
          ),
          ListTile(
            title: GestureDetector(
              onTap: () => showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text("Are you sure?"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("No"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      child: const Text("Yes"),
                      onPressed: () {
                        ref.read(authRepo).signOut();
                        context.go("/");
                      },
                    ),
                  ],
                ),
              ),
              child: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          CheckboxListTile(
            activeColor: Theme.of(context).primaryColor,
            value: false,
            onChanged: (value) {},
            title: const Text("Notifications"),
          ),
          Switch(
            activeColor: Theme.of(context).primaryColor,
            value: false,
            onChanged: (value) {},
          ),
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: false,
            onChanged: (value) {},
          ),
          CupertinoSwitch(
            activeColor: Theme.of(context).primaryColor,
            value: false,
            onChanged: (value) {},
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            value: false,
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
