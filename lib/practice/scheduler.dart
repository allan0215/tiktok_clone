import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScrollController _headerScrollController = ScrollController();
  late final ScrollController _bodyScrollController = ScrollController(
    onAttach: (position) => print("attached"),
  );

  @override
  void initState() {
    super.initState();

    _headerScrollController.addListener(() {
      if (_headerScrollController.hasClients &&
          _bodyScrollController.hasClients) {
        _bodyScrollController.jumpTo(_headerScrollController.offset);
        print(_headerScrollController.position);
      }
    });
    _bodyScrollController.addListener(() {
      print(_bodyScrollController.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              title: Text("Schdule"),
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate:
                    _CustomDelegate(scrollController: _headerScrollController)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                          height: _cellHeight,
                          width: _cellWidth,
                          decoration: _cellDecoration),
                      for (var name in _names)
                        Container(
                          height: _cellHeight,
                          width: _cellWidth,
                          decoration: _cellDecoration,
                          child: Center(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: _cellHeight * (_names.length + 1),
                    width: MediaQuery.of(context).size.width - _cellWidth,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      controller: _bodyScrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        children: [
                          for (var i = 0; i <= _names.length; i++)
                            Container(
                              decoration: _cellDecoration,
                              width: _cellHeight,
                              height: _cellHeight,
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> _names = List.generate(15, (index) => "현수${index + 1}");

final BoxDecoration _cellDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.grey.shade300, width: 1),
);

const double _cellHeight = 60;
const double _cellWidth = 120;

class _CustomDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController scrollController;

  _CustomDelegate({required this.scrollController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Row(
      children: [
        Container(
            height: _cellHeight,
            width: _cellWidth,
            decoration: _cellDecoration),
        SizedBox(
          height: _cellHeight,
          width: MediaQuery.of(context).size.width - _cellWidth,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              decoration: _cellDecoration,
              width: _cellHeight,
              height: _cellHeight,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => _cellHeight;

  @override
  double get minExtent => _cellHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
