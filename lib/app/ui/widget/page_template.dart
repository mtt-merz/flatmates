import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PageTemplate({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.black12,
              elevation: 2,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(title, style: Theme.of(context).textTheme.headline5),
                background: Container(color: Theme.of(context).scaffoldBackgroundColor),
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.all(16),
                // collapseMode: CollapseMode.pin,
              ),
            ),
            SliverList(delegate: SliverChildListDelegate(children)),
          ],
        ),
      );
}
