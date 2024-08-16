import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void _onSearchSubmitted(String value) {
    print("$value submitted");
  }

  void _onSearchChanged(String value) {
    print("typing $value");
  }

  void _onChevronTapped() {
    print("Chevron Tapped");
  }

  void _onSliderTapped() {
    print("Slider Tapped");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size6,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onChevronTapped,
                    child: const FaIcon(FontAwesomeIcons.chevronLeft),
                  ),
                  Gaps.h20,
                  Expanded(
                    child: Container(
                      height: Sizes.size44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: TextField(
                        onChanged: (value) {},
                        controller: _textEditingController,
                        textInputAction: TextInputAction.done,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIconConstraints: const BoxConstraints(maxWidth: 80),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(
                              left: Sizes.size12,
                              right: Sizes.size8,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size16 + Sizes.size2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.size2),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  GestureDetector(
                    onTap: _onSliderTapped,
                    child: const FaIcon(FontAwesomeIcons.sliders),
                  ),
                ],
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Sizes.size16,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(Sizes.size6),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 20,
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size5),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/placeHolder.png",
                            image: "https://picsum.photos/200/300"),
                        // "https://source.unsplash.com/random/?$index"),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      "${constraints.maxWidth} This is ver long caption for my tiktok that i'm uplaod just now currently",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size16 + Sizes.size2,
                          height: 1.1),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    if (constraints.maxWidth < 200 || constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage("https://picsum.photos/200/300"),
                              //"https://source.unsplash.com/random/?1358"),
                              radius: 12,
                            ),
                            Gaps.h4,
                            const Expanded(
                                child: Text(
                              "My avatar is going to be very long",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade500,
                            ),
                            Gaps.h4,
                            const Text(
                              "2.5M",
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size28,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
