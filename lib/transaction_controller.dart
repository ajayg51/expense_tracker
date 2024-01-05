import 'package:expense_tracker/data/transaction_data.dart';
import 'package:expense_tracker/data/transaction_data_model.dart';
import 'package:expense_tracker/enums/transaction_tab_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:image_picker/image_picker.dart';

class TransactionController extends GetxController {
  final data = TransactionData.allTransactionList;
  final currentUserId = 1;
  final currentUserAllTransactionSet = <TransactionDataModel>{}.obs;
  final toPayList = <TransactionDataModel>[].obs;
  final toReceiveList = <TransactionDataModel>[].obs;
  final myExpenseList = <TransactionDataModel>[].obs;
  final currentUserToBeReceivedAmt = 0.obs;
  final currentUserToBePaidAmt = 0.obs;
  final currentUserExpenseAmt = 0.obs;
  final transactionDate = "".obs;
  TransactionDataModel currentUserData = TransactionDataModel.empty();
  final transactionTabList = TransactionTabEnums.values.toList();
  final selectedTabIndex = 0.obs;
  final nameTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final transactionAmtTextController = TextEditingController();
  final imagePath = "".obs;
  final incomeExpenseSwitch = false.obs; // false -> income , true -> expense
  final partialFullPaymentSwitch = false.obs; // false -> partial , true -> full
  final selfOthersTransactionSwitch =
      false.obs; // false -> self transaction, true -> others transaction
  final isAddNewTransactionBtnActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    prepareCurrentUserSelfTransactionData(data: data);
  }

  void prepareCurrentUserSelfTransactionData(
      {required List<Map<String, dynamic>> data}) {
    currentUserAllTransactionSet.clear();
    toPayList.clear();
    toReceiveList.clear();
    myExpenseList.clear();
    currentUserToBePaidAmt.value = 0;
    currentUserToBeReceivedAmt.value = 0;
    currentUserExpenseAmt.value = 0;

    final list =
        data.where((element) => element["id"] == currentUserId).toList();
    if (list.isEmpty) {
      return;
    }
    currentUserData = TransactionDataModel.fromJson(list[0]);

    for (var item in currentUserData.transactionList) {
      if (item["type"] == "income" && item["senderId"] == item["receiverId"]) {
        currentUserData.availAmt += item["amt"] as int;
        // final datumList =
        //     data.where((element) => element["id"] == item["senderId"]).toList();
        // if (datumList.isNotEmpty) {
        //   myExpenseList.add(
        //     TransactionDataModel.fromJson(
        //       {
        //         ...datumList[0],
        //         "transactionDate": item["transactionDate"],
        //       },
        //     ),
        //   );
        // }
      } else if (item["type"] == "expense" &&
          item["senderId"] == item["receiverId"]) {
        currentUserData.availAmt -= item["amt"] as int;
        currentUserExpenseAmt.value += item["amt"] as int;
        final datumList =
            data.where((element) => element["id"] == item["senderId"]).toList();
        if (datumList.isNotEmpty) {
          myExpenseList.add(
            TransactionDataModel.fromJson(
              {
                ...datumList[0],
                "transactionDate": item["transactionDate"],
              },
            ),
          );
        }
      } else if (item["type"] == "income" &&
          item["senderId"] != item["receiverId"]) {
        currentUserData.availAmt += item["amt"] as int;
        currentUserToBePaidAmt.value += item["amt"] as int;
        final datumList =
            data.where((element) => element["id"] == item["senderId"]).toList();
        if (datumList.isNotEmpty) {
          toPayList.add(
            TransactionDataModel.fromJson(
              {
                ...datumList[0],
                "transactionDate": item["transactionDate"],
              },
            ),
          );
        }
      } else if (item["type"] == "expense" &&
          item["senderId"] != item["receiverId"]) {
        currentUserData.availAmt -= item["amt"] as int;
        currentUserToBeReceivedAmt.value += item["amt"] as int;
        final datumList = data
            .where((element) => element["id"] == item["receiverId"])
            .toList();
        if (datumList.isNotEmpty) {
          final dataModel = TransactionDataModel.fromJson(
            {
              ...datumList[0],
              "transactionDate": item["transactionDate"],
            },
          );
          toReceiveList.add(dataModel);
          myExpenseList.add(dataModel);
        }
      }
    }
    currentUserAllTransactionSet.assignAll(toPayList);
    currentUserAllTransactionSet.addAll(toReceiveList);
    currentUserAllTransactionSet.addAll(myExpenseList);
  }

  String get getGreetMsg {
    final dateTimeNow = DateTime.now();
    if (dateTimeNow.hour <= 11 &&
        dateTimeNow.minute <= 59 &&
        dateTimeNow.second <= 59) {
      return "Good morning";
    } else if (dateTimeNow.hour <= 16 &&
        dateTimeNow.minute <= 59 &&
        dateTimeNow.second <= 59) {
      return "Good afternoon";
    } else if (dateTimeNow.hour <= 23 &&
        dateTimeNow.minute <= 59 &&
        dateTimeNow.second <= 59) {
      return "Good evening";
    }
    return "";
  }

  void onTabTap(int index) {
    if (index == selectedTabIndex.value) return;
    selectedTabIndex.value = index;
  }

  TransactionTabEnums get getSelctedTabEnum =>
      TransactionTabEnums.values[selectedTabIndex.value];

  void onPickImageTap() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      imagePath.value = pickedImg.path;
    }
  }

  void onSelfOthersExpenseSwitchChanged() {
    selfOthersTransactionSwitch.toggle();
    validate();
  }

  void onIncomeExpenseSwitchChanged() {
    incomeExpenseSwitch.toggle();
  }

  void onPartailFullPaymentSwitchChanged() {
    partialFullPaymentSwitch.toggle();
  }

  void validate() {
    Debouncer(delay: const Duration(milliseconds: 300)).call(() {
      if (!selfOthersTransactionSwitch.value) {
        // if its self transaction
        if (transactionAmtTextController.text.trim().isNotEmpty) {
          isAddNewTransactionBtnActive.value = true;
        } else {
          isAddNewTransactionBtnActive.value = false;
        }
      } else {
        if (nameTextController.text.trim().isNotEmpty &&
            mobileTextController.text.trim().isNotEmpty &&
            transactionAmtTextController.text.trim().isNotEmpty) {
          isAddNewTransactionBtnActive.value = true;
        } else {
          isAddNewTransactionBtnActive.value = false;
        }
      }
    });
  }

  void onAddNewTransactionBtn({required BuildContext context}) {
    final receiverId = int.tryParse(mobileTextController.text.trim()) ?? 0;
    if (receiverId == currentUserId || receiverId > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please choose a valid receiver id")));
      return;
    }
    if (!selfOthersTransactionSwitch.value) {
      // if its self transaction add transaction amt as an income
      addSelfTransactionDetails(context: context);
    } else {
      addOthersTransactionDetails(context: context);
    }
  }

  void addSelfTransactionDetails({required BuildContext context}) {
    for (var item in TransactionData.allTransactionList) {
      if (item["id"] == currentUserId) {
        final list = item["transactionList"] as List<Map<String, dynamic>>;
        if (incomeExpenseSwitch.value) {
          final mapList = list
              .where((element) =>
                  element["type"] == "expense" &&
                  element["senderId"] == element["receiverId"])
              .toList();
          if (mapList.isNotEmpty) {
            Map<String, dynamic> map = mapList[0];
            final int expenseAmt = map["amt"];
            final int newExpenseAmt =
                int.tryParse(transactionAmtTextController.text.trim()) ?? 0;
            map["amt"] = (expenseAmt + newExpenseAmt).toString();
            map["transactionDate"] = DateTime.now().toString();

            list.removeWhere((element) =>
                element["type"] == "expense" &&
                element["senderId"] == element["receiverId"]);
            list.add(map);

            TransactionData.allTransactionList.map((e) {
              if (e["id"] == currentUserId) {
                e["transactionList"].clear();
                e["transactionList"].assignAll(list);
              }
            });
          }
        } else {
          final mapList = list
              .where((element) =>
                  element["type"] == "income" &&
                  element["senderId"] == element["receiverId"])
              .toList();
          if (mapList.isNotEmpty) {
            Map<String, dynamic> map = mapList[0];
            final int incomeAmt = map["amt"];
            final int newIncomeAmt =
                int.tryParse(transactionAmtTextController.text.trim()) ?? 0;
            map["amt"] = (incomeAmt + newIncomeAmt).toString();
            map["transactionDate"] = DateTime.now().toString();

            list.removeWhere((element) =>
                element["type"] == "income" &&
                element["senderId"] == element["receiverId"]);
            list.add(map);
            TransactionData.allTransactionList.map((e) {
              if (e["id"] == currentUserId) {
                e["transactionList"].clear();
                e["transactionList"].assignAll(list);
              }
            });
          }
        }
        transactionAmtTextController.clear();
        isAddNewTransactionBtnActive.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully added a new transaction'),
          ),
        );
        prepareCurrentUserSelfTransactionData(
            data: TransactionData.allTransactionList);
        Navigator.pop(context);
        return;
      }
    }
  }

  void addOthersTransactionDetails({required BuildContext context}) {
    final senderIdInt = currentUserId;

    final receiverIdInt = int.tryParse(mobileTextController.text.trim());
    final newExpenseInt =
        int.tryParse(transactionAmtTextController.text.trim());
    final isIncome = !incomeExpenseSwitch.value;
    final isExpense = incomeExpenseSwitch.value;

    bool isReceiverEntryDone = false;
    bool isSenderEntryDone = false;

    for (var item in TransactionData.allTransactionList) {
      if (item["id"] == senderIdInt) {
        final senderTransactionList =
            item["transactionList"] as List<Map<String, dynamic>>;
        if (isIncome) {
          final incomeTransactionList = senderTransactionList
              .where((element) =>
                  element["type"] == "income" &&
                  element["senderId"] == senderIdInt &&
                  element["receiverId"] == receiverIdInt)
              .toList();

          if (incomeTransactionList.isNotEmpty) {
            incomeTransactionList[0]["amt"] += newExpenseInt;
            incomeTransactionList[0]["transactionDate"] =
                DateTime.now().toString();
            if (imagePath.value.isNotEmpty) {
              item["imagePath"] = imagePath.value;
            }
            isSenderEntryDone = true;
            // print("here : ");
            // print("");
            // print(TransactionData.allTransactionList
            //     .where((element) => element["id"] == senderIdInt));
          } else {
            final newTransactionEntryMap = {
              "type": "income",
              "senderId": senderIdInt,
              "receiverId": receiverIdInt,
              "amt": newExpenseInt,
              "transactionDate": DateTime.now().toString(),
            };
            item["transactionList"].add(newTransactionEntryMap);
            if (imagePath.value.isNotEmpty) {
              item["imagePath"] = imagePath.value;
            }
            isSenderEntryDone = true;
            // print("here : ");
            // print("");
            // print(TransactionData.allTransactionList
            //     .where((element) => element["id"] == senderIdInt));
          }
        } else {
          final expenseTransactionList = senderTransactionList
              .where((element) =>
                  element["type"] == "expense" &&
                  element["senderId"] == senderIdInt &&
                  element["receiverId"] == receiverIdInt)
              .toList();

          if (expenseTransactionList.isNotEmpty) {
            expenseTransactionList[0]["amt"] += newExpenseInt;
            expenseTransactionList[0]["transactionDate"] =
                DateTime.now().toString();
            if (imagePath.value.isNotEmpty) {
              item["imagePath"] = imagePath.value;
            }
            isSenderEntryDone = true;
            // print("here : ");
            // print("");
            // print(TransactionData.allTransactionList
            //     .where((element) => element["id"] == senderIdInt));
          } else {
            final newTransactionEntryMap = {
              "type": "expense",
              "senderId": senderIdInt,
              "receiverId": receiverIdInt,
              "amt": newExpenseInt,
              "transactionDate": DateTime.now().toString(),
            };
            item["transactionList"].add(newTransactionEntryMap);
            if (imagePath.value.isNotEmpty) {
              item["imagePath"] = imagePath.value;
            }
            isSenderEntryDone = true;
            // print("here : ");
            // print("");
            // print(TransactionData.allTransactionList
            //     .where((element) => element["id"] == senderIdInt));
          }
        }
      }

      if (item["id"] == receiverIdInt) {
        final receiverTransactionList =
            item["transactionList"] as List<Map<String, dynamic>>;

        final requiredTransactionList = receiverTransactionList
            .where((element) =>
                element["type"] == "income" &&
                element["senderId"] == senderIdInt &&
                element["receiverId"] == receiverIdInt)
            .toList();
        if (requiredTransactionList.isNotEmpty) {
          requiredTransactionList[0]["amt"] += newExpenseInt;
          requiredTransactionList[0]["transactionDate"] =
              DateTime.now().toString();
          if (imagePath.value.isNotEmpty) {
            item["imagePath"] = imagePath.value;
          }
          isReceiverEntryDone = true;
          // print("here : ");
          // print("");
          // print(TransactionData.allTransactionList
          //     .where((element) => element["id"] == receiverIdInt));
        } else {
          final newTransactionEntryMap = <String, dynamic>{
            "type": "income",
            "senderId": senderIdInt,
            "receiverId": receiverIdInt,
            "amt": newExpenseInt,
            "transactionDate": DateTime.now().toString(),
          };
          item["transactionList"].add(newTransactionEntryMap);
          if (imagePath.value.isNotEmpty) {
            item["imagePath"] = imagePath.value;
          }
          isReceiverEntryDone = true;
          // print("here : ");
          // print("");
          // print(TransactionData.allTransactionList
          //     .where((element) => element["id"] == receiverIdInt));
        }
      }

      if (isSenderEntryDone && isReceiverEntryDone) {
        incomeExpenseSwitch.value = false;
        selfOthersTransactionSwitch.value = false;
        partialFullPaymentSwitch.value = false;
        nameTextController.clear();
        mobileTextController.clear();
        transactionAmtTextController.clear();
        isAddNewTransactionBtnActive.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully added a new transaction'),
          ),
        );
        print(TransactionData.allTransactionList
            .where((element) => element["id"] == senderIdInt));
        print("");

        print(TransactionData.allTransactionList
            .where((element) => element["id"] == receiverIdInt));
        prepareCurrentUserSelfTransactionData(
            data: TransactionData.allTransactionList);
        Navigator.pop(context);
        return;
      }
    }
  }
}
