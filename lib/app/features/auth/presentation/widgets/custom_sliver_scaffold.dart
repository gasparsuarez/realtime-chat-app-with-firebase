import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

///
/// Scaffold with CustomScrollView
///
/// Contains title and subtitle for auth pages
///
class CustomSliverScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const CustomSliverScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        textColor: kBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: context.w * 0.08,
                      ),
                      CustomText(
                        text: subtitle,
                        textColor: kBlackColor,
                        fontSize: context.w * 0.04,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
