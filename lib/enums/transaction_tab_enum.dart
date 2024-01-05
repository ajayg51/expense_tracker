enum TransactionTabEnums {
  all,
  toBeReceived,
  toBePaid,
  myExpenses,
  // received,
  // paid,
  none,
}

extension TransactionTabEnumExt on TransactionTabEnums {
  String get getLabel {
    switch (this) {
      case TransactionTabEnums.all:
        return "All";
      case TransactionTabEnums.toBeReceived:
        return "To be received";
      case TransactionTabEnums.toBePaid:
        return "To be paid";
      case TransactionTabEnums.myExpenses:
        return "My expenses";
      // case TransactionTabEnums.received:
      //   return "Received";
      // case TransactionTabEnums.paid:
      //   return "Paid";
      default:
        return "";
    }
  }
}
