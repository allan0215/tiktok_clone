import 'dart:math';

import 'package:flutter/material.dart';

class ParadeGameScreen extends StatefulWidget {
  const ParadeGameScreen({super.key});

  @override
  State<ParadeGameScreen> createState() => _ParadeGameScreenState();
}

class _ParadeGameScreenState extends State<ParadeGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("parade game"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
              ),
              Positioned(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 60,
                  child: AspectRatio(
                    aspectRatio: 5 / 8,
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 6,
                          left: 8,
                          child: Text("2"),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 8,
                          child: Transform.rotate(
                              angle: pi, child: const Text("2")),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Text("bottom"),
      ),
    );
  }
}
