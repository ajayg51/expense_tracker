import 'package:expense_tracker/data/transaction_data_model.dart';
import 'package:expense_tracker/enums/transaction_tab_enum.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';

class AllTransactionView extends StatelessWidget {
  const AllTransactionView({
    super.key,
    required this.data,
    required this.viewType,
    required this.currentUserId,
  });
  final List<TransactionDataModel> data;
  final int currentUserId;
  final TransactionTabEnums viewType;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: data.length * 2 - 1,
          itemBuilder: (_, index) {
            final actualIndex = index ~/ 2;
            final item = data[actualIndex];
            if (index % 2 == 0 && item.id != currentUserId) {
              print(item.transactionList);
              print("\n\n\n\n");
              String amtToBeReceived = "";
              String amtToBePaid = "";
              if (viewType == TransactionTabEnums.all ||
                  viewType == TransactionTabEnums.toBeReceived) {
                final amtToBeReceivedUserList = item.transactionList
                    .where((e) =>
                        e["senderId"] == currentUserId &&
                        e["receiverId"] == item.id)
                    .toList();
                if (amtToBeReceivedUserList.isNotEmpty) {
                  amtToBeReceived =
                      amtToBeReceivedUserList[0]["amt"].toString();
                }
              }

              if (viewType == TransactionTabEnums.all ||
                  viewType == TransactionTabEnums.toBePaid) {
                final amtToBePaidUserList = item.transactionList
                    .where((e) =>
                        e["senderId"] == item.id &&
                        e["receiverId"] == currentUserId)
                    .toList();
                if (amtToBePaidUserList.isNotEmpty) {
                  amtToBePaid = amtToBePaidUserList[0]["amt"].toString();
                }
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.phone_android_outlined),
                              Text(
                                item.mob,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Text(
                      "How much ${item.name} will pay me?",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    5.verticalSpace,
                    buildTransactionList(amt: amtToBeReceived),
                    5.verticalSpace,
                    Text(
                      "How much I have to pay to ${item.name}?",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    5.verticalSpace,
                    buildTransactionList(amt: amtToBePaid),
                  ],
                ).withPaddingAll(value: 10),
              );
            }
            return 5.verticalSpace;
          },
        ),
      ],
    );
  }

  Widget buildTransactionList({required String amt}) {
    Widget content = const Text("We don't owe any amount to each other.");
    if (amt.isNotEmpty) {
      content = Text(
        'Amt : ${Constants.rupeeSymbol}$amt',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: content.withPaddingAll(value: 5),
    );
  }
}
