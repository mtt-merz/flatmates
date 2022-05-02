import 'package:flatmates/app/ui/utils/size.dart';
import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;

  final void Function() onRefresh;

  const PageTemplate({
    Key? key,
    required this.title,
    required this.children,
    this.floatingActionButton,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          floatingActionButton: floatingActionButton,
          body: RefreshIndicator(
            onRefresh: () async => onRefresh(),
            child: CustomScrollView(slivers: [
              SliverAppBar(
                expandedHeight: 100,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.black12,
                elevation: 2,
                flexibleSpace: FlexibleSpaceBar(
                  title:
                      Text(title, style: Theme.of(context).textTheme.headline5),
                  background: Container(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  expandedTitleScale: 1,
                  titlePadding: EdgeInsetsDirectional.only(
                      start: SizeUtils.of(context).horizontalPaddingValue,
                      bottom: 16.0),
                ),
              ),
              SliverPadding(
                  padding: SizeUtils.of(context).basePadding,
                  sliver:
                      SliverList(delegate: SliverChildListDelegate(children))),
            ]),
          ),
        ),
      );
}
