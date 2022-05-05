import 'package:flatmates/app/ui/utils/size.dart';
import 'package:flutter/material.dart';

class ScreenTemplate extends StatefulWidget {
  final String title;
  final String? subtitle;

  final List<Widget>? actions;
  final List<Widget> children;
  final Widget? footer;
  final FloatingActionButton? floatingActionButton;

  final VoidCallback? onPop;

  const ScreenTemplate({
    Key? key,
    required this.title,
    this.subtitle,
    required this.children,
    this.actions,
    this.onPop,
    this.floatingActionButton,
    this.footer,
  }) : super(key: key);

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  final expandedHeight = 130.0;
  String? subtitle;

  VoidCallback get pop => widget.onPop ?? Navigator.of(context).pop;

  @override
  Widget build(BuildContext context) {
    subtitle = widget.subtitle;

    return WillPopScope(
      onWillPop: () {
        pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                scrollBehavior: NoOverscrollBehavior(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: expandedHeight,
                    snap: true,
                    floating: true,
                    elevation: 2,
                    actions: widget.actions,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: pop,
                    ),
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final expansionPercentage = (constraints.maxHeight -
                                MediaQuery.of(context).padding.top -
                                kToolbarHeight) /
                            (expandedHeight - kToolbarHeight);

                        final double scaleValue =
                            Tween<double>(begin: 1, end: 1.8)
                                .transform(expansionPercentage);

                        final x = (1 - expansionPercentage) * 36 +
                            SizeUtils.of(context).horizontalPaddingValue;
                        final y = constraints.maxHeight - kToolbarHeight + 16;

                        final transform = Matrix4.translationValues(x, y, 0.0)
                          ..scale(scaleValue, scaleValue, 2);
                        return Transform(
                          transform: transform,
                          child: Text(widget.title,
                              style: Theme.of(context).textTheme.headline6),
                        );
                      },
                    ),
                  ),

                  // Body
                  SliverPadding(
                    padding: SizeUtils.of(context).basePadding,
                    sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed([
                      // Container(height: SizeUtils.of(context).getScaledHeight(10)),
                      // Text(widget.title,
                      //     textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline4),
                      // SizedBox(height: SizeUtils.of(context).getScaledHeight(1)),
                      widget.subtitle != null
                          ? Text(widget.subtitle!)
                          : const SizedBox(),
                      SizedBox(
                          height: SizeUtils.of(context).getScaledHeight(4)),
                      ...widget.children,
                    ])),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: widget.footer == null
            ? null
            : Material(
                elevation: 12,
                color: Colors.white,
                child: Container(
                  padding: SizeUtils.of(context).basePadding,
                  child: widget.footer,
                ),
              ),
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}

class NoOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
