import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() =>
      __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Dog', 'Cat', 'Fox', 'Rabbit'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Digital Pet'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Dog
          Center(
            child: Image.network(
              'https://placedog.net/600/600?id=1',
              fit: BoxFit.contain,
            ),
          ),

          // Cat
          Center(
            child: Image.network(
              'https://placekitten.com/600/600',
              fit: BoxFit.contain,
            ),
          ),

          // Fox
          Center(
            child: Image.network(
              'https://images.unsplash.com/photo-1601758123927-3f89f2b7ff46?auto=format&fit=crop&w=600&q=80',
              fit: BoxFit.contain,
            ),
          ),

          // Rabbit
          Center(
            child: Image.network(
              'https://images.unsplash.com/photo-1617121471493-0517e5e5e1e3?auto=format&fit=crop&w=600&q=80',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}


