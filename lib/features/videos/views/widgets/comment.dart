import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class VideoComment extends StatefulWidget {
  const VideoComment({super.key});

  @override
  State<VideoComment> createState() => _VideoCommentState();
}

class _VideoCommentState extends State<VideoComment> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isWriting = false;

  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
          automaticallyImplyLeading: false,
          title: Text(S.of(context).comments(5426, 5426)),
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    left: Sizes.size16,
                    right: Sizes.size16,
                    bottom: Sizes.size96 + Sizes.size20,
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Text("션후"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "션후",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            const Text(
                              "That's not it I've seen the same thing but also in a cave",
                              style: TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                          Gaps.v2,
                          Text(
                            "52.2k",
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                width: size.width,
                bottom: 0,
                child: BottomAppBar(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size8,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        child: const Text("션후"),
                      ),
                      Gaps.h14,
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            onTap: _onStartWriting,
                            controller: _textEditingController,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            textInputAction: TextInputAction.newline,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: Sizes.size14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: Colors.grey.shade900,
                                    ),
                                    if (_isWriting) Gaps.h14,
                                    if (_isWriting)
                                      GestureDetector(
                                        onTap: _stopWriting,
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowUp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              hintText: "Write a comment...",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
