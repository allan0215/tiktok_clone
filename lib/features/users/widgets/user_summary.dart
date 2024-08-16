import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserSummary extends StatelessWidget {
  final String amount;
  final String description;

  const UserSummary({
    super.key,
    required this.amount,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          description,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        )
      ],
    );
  }
}
