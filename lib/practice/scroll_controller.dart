import 'package:flutter/material.dart';

class ScrollControllerPracticeScreen extends StatefulWidget {
  const ScrollControllerPracticeScreen({super.key});

  @override
  State<ScrollControllerPracticeScreen> createState() =>
      _ScrollControllerPracticeScreenState();
}

class _ScrollControllerPracticeScreenState
    extends State<ScrollControllerPracticeScreen> {
  final ScrollController _tealController = ScrollController(
    onAttach: (position) => print("teal attached"),
    onDetach: (position) => print("teal detached"),
  );
  late final ScrollController _orangeController = ScrollController();
  final ScrollController _mainController = ScrollController();
  final GlobalKey _key = GlobalKey(debugLabel: "x");

  @override
  void initState() {
    super.initState();
    _mainController.addListener(() {
      _tealController.jumpTo(_mainController.offset);
      _orangeController.jumpTo(_mainController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("scroll controller"),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    controller: _tealController,
                    child: Container(
                      key: _key,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.teal.shade100,
                            Colors.teal.shade900,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  controller: _orangeController,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.orange.shade900,
                          Colors.orange.shade100,
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
/*           const ModalBarrier(),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _mainController,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ) */
        ],
      ),
    );
  }
}
