import 'dart:ffi';

import 'package:expense_tracker/data/transaction_data_model.dart';
import 'package:expense_tracker/enums/transaction_tab_enum.dart';
import 'package:expense_tracker/new_transaction_screen.dart';
import 'package:expense_tracker/transaction_controller.dart';
import 'package:expense_tracker/transaction_views/all_transaction_view.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/extensions.dart';
import 'package:expense_tracker/utils/separator.dart';
import 'package:expense_tracker/utils/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final controller =
      Get.put(TransactionController(), tag: "transactionController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal,
                Colors.amber,
                Color.fromARGB(255, 70, 67, 67),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(28),
              color: Colors.black.withOpacity(0.4),
            ),
            child: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NewTransactionScreen(),
                  ),
                );
              },
              child: const Text(
                "New transaction",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          5.horizontalSpace,
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.amber,
              Color.fromARGB(255, 70, 67, 67),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${controller.getGreetMsg}! ${controller.currentUserData.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ).withPaddingSymmetric(horizontal: 5),
            const Separator().withPaddingSymmetric(horizontal: 5),
            5.verticalSpace,
            buildAmtInfoGridView.withPaddingSymmetric(horizontal: 5),
            5.verticalSpace,
            const Text(
              "Transactions",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ).withPaddingSymmetric(horizontal: 5),
            const Separator().withPaddingSymmetric(horizontal: 5),
            10.verticalSpace,
            buildTransactionTabs.withPaddingSymmetric(horizontal: 5),
            5.verticalSpace,
            Expanded(
              flex: 4,
              child: buildTabBasisView.withPaddingSymmetric(horizontal: 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget get buildAmtInfoGridView {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 51, 50, 50),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Available amount"),
                      2.verticalSpace,
                      Text(
                          "${Constants.rupeeSymbol}${controller.currentUserData.availAmt}")
                    ],
                  ),
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 51, 50, 50),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Amount to be received"),
                      2.verticalSpace,
                      Obx(() {
                        return Text(
                            "${Constants.rupeeSymbol}${controller.currentUserToBeReceivedAmt}");
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          5.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 51, 50, 50),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("My Expenses"),
                      2.verticalSpace,
                      Obx(() {
                        return Text(
                            "${Constants.rupeeSymbol}${controller.currentUserExpenseAmt}");
                      }),
                    ],
                  ),
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 51, 50, 50),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Amount to be paid"),
                      2.verticalSpace,
                      Obx(() {
                        return Text(
                            "${Constants.rupeeSymbol}${controller.currentUserToBePaidAmt}");
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get buildTransactionTabs {
    final tabList = controller.transactionTabList;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: AppTabBar<TransactionTabEnums>(
        tabList: tabList,
        onTap: controller.onTabTap,
      ),
    );
  }

  Widget get buildTabBasisView {
    return Obx(() {
      final selectedTabEnum = controller.getSelctedTabEnum;
      final allUserData = controller.currentUserAllTransactionSet;
      final toReceivePaymentData = controller.toReceiveList;
      final toPayPaymentData = controller.toReceiveList;
      final expensesData = controller.myExpenseList;
      switch (selectedTabEnum) {
        case TransactionTabEnums.all:
          return AllTransactionView(
            data: allUserData.toList(),
            viewType: selectedTabEnum,
            currentUserId: controller.currentUserId,
          );
        case TransactionTabEnums.toBeReceived:
          return AllTransactionView(
            data: toReceivePaymentData,
            viewType: selectedTabEnum,
            currentUserId: controller.currentUserId,
          );
        case TransactionTabEnums.toBePaid:
          return AllTransactionView(
            data: toPayPaymentData,
            viewType: selectedTabEnum,
            currentUserId: controller.currentUserId,
          );
        case TransactionTabEnums.myExpenses:
          return buildTransactionList(list: expensesData);
        default:
          return const SizedBox.shrink();
      }
    });
  }

  Widget buildTransactionList({required List<TransactionDataModel> list}) {
    if (list.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text("No data content").withPaddingAll(value: 5),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: list.length * 2,
          itemBuilder: (_, index) {
            if (index % 2 == 0) {
              final item = list[index ~/ 2];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Receiver ID : ${item.id}"),
                    Text('${Constants.rupeeSymbol}${controller.currentUserToBeReceivedAmt.toString()}')
                        .withPaddingAll(value: 5),
                    Text(
                        'On ${DateFormat("MMM d yyyy, h:mm a").format(DateTime.parse(item.transactionDate))}')
                  ],
                ).withPaddingSymmetric(horizontal: 5),
              );
            }
            return 5.verticalSpace;
          },
        ),
      ],
    );
  }
}
