import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';

class OtherTransactionTypeView extends StatelessWidget {
  const OtherTransactionTypeView({
    super.key,
    required this.data,
  });
  final List<Map<String, dynamic>> data;
  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data found"));
    }
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: data.length * 2 - 1,
          itemBuilder: (_, index) {
            final actualIndex = index ~/ 2;
            final item = data[actualIndex];
            if (index % 2 == 0) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
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
                            'Id : ${item["id"]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${Constants.rupeeSymbol}${item["amt"]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
}
