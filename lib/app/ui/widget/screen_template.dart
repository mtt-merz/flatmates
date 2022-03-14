import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/material.dart';

class ScreenTemplate extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  final void Function()? onClose;

  const ScreenTemplate(
      {Key? key, required this.title, required this.subtitle, required this.children, this.onClose})
      : super(key: key);

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  String? subtitle;

  @override
  Widget build(BuildContext context) {
    subtitle = widget.subtitle;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(scrollBehavior: NoOverscrollBehavior(), slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          expandedHeight: 150,
          snap: true,
          floating: true,
          // onStretchTrigger: () => subtitle = null,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.title, style: Theme.of(context).textTheme.titleSmall),
            titlePadding: EdgeInsetsDirectional.only(
                start: SizeUtils.of(context).listScreenPadding.horizontal / 2, bottom: 26.0),
          ),
          actions: [
            widget.onClose != null
                ? IconButton(icon: const Icon(Icons.close), onPressed: widget.onClose)
                : const SizedBox()
          ],
        ),
        SliverPadding(
          padding: SizeUtils.of(context).listScreenPadding,
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                // Container(height: SizeUtils.of(context).getScaledHeight(10)),
                // Text(widget.title,
                //     textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline4),
                // SizedBox(height: SizeUtils.of(context).getScaledHeight(1)),
                // Text(widget.subtitle),
                // SizedBox(height: SizeUtils.of(context).getScaledHeight(4)),
                ...widget.children,
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class NoOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
