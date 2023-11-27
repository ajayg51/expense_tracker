import 'package:expense_tracker/enums/transaction_tab_enum.dart';
import 'package:flutter/material.dart';

class AppTabBar<T> extends StatefulWidget {
  const AppTabBar({
    super.key,
    required this.tabList,
    required this.onTap,
  });
  final List<T> tabList;

  final Function(int) onTap;

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabList = widget.tabList as List<TransactionTabEnums>;
    return TabBar(
      onTap: widget.onTap,
      padding: EdgeInsets.zero,
      isScrollable: true,
      indicatorColor: const Color.fromARGB(255, 4, 1, 104),
      labelColor: const Color.fromARGB(255, 4, 1, 104),
      unselectedLabelColor: Colors.black,
      dividerColor: Colors.transparent,
      controller: TabController(length: tabList.length, vsync: this),
      tabs: tabList.map((e) => Text(e.getLabel)).toList(),
    );
  }
}
