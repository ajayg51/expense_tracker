import 'dart:io';

import 'package:expense_tracker/transaction_controller.dart';
import 'package:expense_tracker/transaction_screen.dart';
import 'package:expense_tracker/utils/assets.dart';
import 'package:expense_tracker/utils/common_background_gradient.dart';
import 'package:expense_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewTransactionScreen extends StatelessWidget {
  NewTransactionScreen({super.key});

  late final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<TransactionController>(tag: "transactionController")) {
      controller =
          Get.find<TransactionController>(tag: "transactionController");
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => TransactionScreen()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New transaction screen",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        flexibleSpace: const CommonBackgroundGradient(),
      ),
      body: CommonBackgroundGradient(
        child: buildChild(context: context),
      ),
    );
  }

  Widget buildChild({required BuildContext context}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.verticalSpace,
          buildSelfOthersExpenseSwitch.withPaddingSymmetric(horizontal: 5),
          5.verticalSpace,
          buildIncomeExpenseSwitch.withPaddingSymmetric(horizontal: 5),
          Obx(() {
            if (controller.selfOthersTransactionSwitch.value) {
              return Column(
                children: [
                  5.verticalSpace,
                  buildPartialFullPaymentSwitch.withPaddingSymmetric(
                      horizontal: 5),
                  10.verticalSpace,
                  buildPickCustomerImageFromGallery.withPaddingSymmetric(
                      horizontal: 5),
                  10.verticalSpace,
                  buildNameInputField.withPaddingSymmetric(horizontal: 5),
                  10.verticalSpace,
                  buildMobileInputField.withPaddingSymmetric(horizontal: 5),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
          10.verticalSpace,
          buildTransactionAmtInputField.withPaddingSymmetric(horizontal: 5),
          40.verticalSpace,
          Row(
            children: [
              Expanded(
                child: buildAddNewTransactionBtn(context: context),
              )
            ],
          ).withPaddingSymmetric(horizontal: 5),
        ],
      ),
    );
  }

  Widget get buildPickCustomerImageFromGallery {
    return InkWell(
      onTap: controller.onPickImageTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Obx(() {
              if (controller.imagePath.isEmpty) {
                return SvgPicture.asset(
                  Assets.avatarIcon,
                  height: 200,
                );
              }
              return Image.file(
                File(controller.imagePath.value),
                height: 200,
              );
            }),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(0.1),
                alignment: Alignment.center,
                child: const Text("Pick image from gallery"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get buildNameInputField {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        onChanged: (str) => controller.validate(),
        controller: controller.nameTextController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
        ],
        decoration: const InputDecoration.collapsed(
          focusColor: Colors.black,
          hintText: "Please enter name",
        ),
      ),
    );
  }

  Widget get buildMobileInputField {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        onChanged: (str) => controller.validate(),
        controller: controller.mobileTextController,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[+0-9]"))],
        decoration: const InputDecoration.collapsed(
          focusColor: Colors.black,
          hintText: "Please enter mobile no.",
        ),
      ),
    );
  }

  Widget get buildTransactionAmtInputField {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        onChanged: (str) => controller.validate(),
        controller: controller.transactionAmtTextController,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[+0-9]"))],
        decoration: const InputDecoration.collapsed(
          focusColor: Colors.black,
          hintText: "Please enter transaction amount",
        ),
      ),
    );
  }

  Widget get buildSelfOthersExpenseSwitch {
    return Row(
      children: [
        const Expanded(child: Text("Self transaction")),
        Expanded(
          child: Obx(() {
            return Switch(
              activeColor: Colors.black,
              value: controller.selfOthersTransactionSwitch.value,
              onChanged: (value) =>
                  controller.onSelfOthersExpenseSwitchChanged(),
            );
          }),
        ),
        const Expanded(child: Text("Others transaction"))
      ],
    );
  }

  Widget get buildIncomeExpenseSwitch {
    return Row(
      children: [
        const Expanded(child: Text("As an income")),
        Expanded(
          child: Obx(() {
            return Switch(
              activeColor: Colors.black,
              value: controller.incomeExpenseSwitch.value,
              onChanged: (value) => controller.onIncomeExpenseSwitchChanged(),
            );
          }),
        ),
        const Expanded(child: Text("As an expense"))
      ],
    );
  }

  Widget get buildPartialFullPaymentSwitch {
    return Row(
      children: [
        const Expanded(child: Text("Partial payment")),
        Expanded(
          child: Obx(() {
            return Switch(
              activeColor: Colors.black,
              value: controller.partialFullPaymentSwitch.value,
              onChanged: (value) =>
                  controller.onPartailFullPaymentSwitchChanged(),
            );
          }),
        ),
        const Expanded(child: Text("Full payment"))
      ],
    );
  }

  Widget buildAddNewTransactionBtn({required BuildContext context}) {
    return Obx(
      () {
        final isBtnActive = controller.isAddNewTransactionBtnActive.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(28),
            color: isBtnActive
                ? Colors.black.withOpacity(0.4)
                : Colors.white.withOpacity(0.2),
          ),
          child: InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => isBtnActive
                ? controller.onAddNewTransactionBtn(context: context)
                : null,
            child: const Text(
              "Add a new transaction",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}
