import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/material.dart';

class ScreenTemplate extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? footer;
  final FloatingActionButton? floatingActionButton;

  final VoidCallback? onPop;

  const ScreenTemplate({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.onPop,
    this.floatingActionButton,
    this.footer,
  }) : super(key: key);

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
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
                    expandedHeight: 150,
                    snap: true,
                    floating: true,
                    elevation: 2,
                    // onStretchTrigger: () => subtitle = null,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(widget.title, style: Theme.of(context).textTheme.headline6),
                      titlePadding: EdgeInsetsDirectional.only(
                          start: SizeUtils.of(context).listScreenPadding.horizontal / 2,
                          bottom: 16.0),
                    ),
                    actions: [IconButton(icon: const Icon(Icons.close), onPressed: pop)],
                  ),

                  // Body
                  SliverPadding(
                    padding: SizeUtils.of(context).listScreenPadding,
                    sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed([
                      // Container(height: SizeUtils.of(context).getScaledHeight(10)),
                      // Text(widget.title,
                      //     textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline4),
                      // SizedBox(height: SizeUtils.of(context).getScaledHeight(1)),
                      Text(widget.subtitle),
                      SizedBox(height: SizeUtils.of(context).getScaledHeight(4)),
                      ...widget.children,
                    ])),
                  ),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: SizeUtils.of(context).basePadding,
              child: widget.footer,
            ),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}

class NoOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
