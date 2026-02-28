import 'package:flutter/material.dart';

import '../widgets/product_tab_view.dart';
import '../widgets/search_bar_header.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const HomeScreen({super.key, required this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Jewelery', 'Mens Cloth', 'Electronics'];
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            toolbarHeight: 0,
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background:  SearchBarHeader(data: widget.data,),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: tabs.map((label) => Tab(text: label)).toList(),
              indicatorColor: Colors.amber,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
            ),
          ),
        ],
        body: PageStorage(
          bucket: _bucket,
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((tab) => ProductTabView(tab: tab)).toList(),
          ),
        ),
      ),
    );
  }
}
