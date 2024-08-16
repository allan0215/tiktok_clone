import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final TextEditingController _textEditingController = TextEditingController();
  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  final List<String> _messages = List.generate(10, (index) => "this is a message");

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    setState(() {
      _messages.add(_textEditingController.text);
    });

    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: SizedBox(
            width: Sizes.size48,
            height: Sizes.size48,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: Sizes.size44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.shade200,
                    ),
                    child: const Center(
                      child: Text(
                        "션후",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: Sizes.size16,
                    height: Sizes.size16,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: 5,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          ),
          title: Text(
            "션후 ${widget.chatId}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size20, horizontal: Sizes.size14),
                    itemBuilder: (context, index) {
                      final isMine = index % 2 == 0;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Sizes.size14),
                            decoration: BoxDecoration(
                                color: isMine ? Colors.blue : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(Sizes.size20),
                                    topRight: const Radius.circular(Sizes.size20),
                                    bottomLeft:
                                        Radius.circular(isMine ? Sizes.size20 : Sizes.size5),
                                    bottomRight:
                                        Radius.circular(isMine ? Sizes.size5 : Sizes.size20))),
                            child: Text(
                              _messages[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: _messages.length),
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _dismissKeyboard,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: Sizes.size48,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size16),
                      ),
                      child: TextField(
                        onChanged: (value) => print(value),
                        textInputAction: TextInputAction.newline,
                        controller: _textEditingController,
                        textAlignVertical: TextAlignVertical.center,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                          suffixIconConstraints: const BoxConstraints.tightFor(),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(right: Sizes.size12),
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              size: Sizes.size24,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                          hintText: "Send a message...",
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.paperPlane),
                    onPressed: _onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
