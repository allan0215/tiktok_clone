import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settins_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_summary.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username, tab;
  const UserProfileScreen({super.key, required this.username, required this.tab});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearTapped() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: _onGearTapped,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  )
                ],
              ),
              body: Center(child: Text(error.toString()))),
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          data: (data) => Scaffold(
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(
                          data.name,
                        ),
                        actions: [
                          IconButton(
                            onPressed: _onGearTapped,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          )
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Avatar(
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                              uid: data.uid,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.h5,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size16,
                                  color: Colors.blue.shade500,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            SizedBox(
                              height: Sizes.size52,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const UserSummary(amount: "97", description: "Following"),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade400,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  const UserSummary(amount: "10M", description: "Followers"),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade400,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  const UserSummary(amount: "194.3M", description: "Likes"),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            FractionallySizedBox(
                              widthFactor: 0.33,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size12,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(Sizes.size4),
                                ),
                                child: const Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                "All highlights and where to watch live matches on FIFA+",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  "http://www.google.com",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: CustomTabBarDelegate(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: Sizes.size2,
                            mainAxisSpacing: Sizes.size2,
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 4,
                          ),
                          itemBuilder: (context, index) => Column(
                            children: [
                              Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 3 / 4,
                                    child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: "assets/images/placeHolder.png",
                                        image: "http://localhost:3000/images/6"),
                                  ),
                                  Positioned(
                                    bottom: Sizes.size3,
                                    left: Sizes.size5,
                                    child: Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.play,
                                          color: Colors.white,
                                          size: Sizes.size16,
                                        ),
                                        Gaps.h5,
                                        Text(
                                          "${index}M",
                                          style: const TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Likes",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
