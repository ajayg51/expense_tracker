class TransactionDataModel {
  int id;
  String name;
  String mob;
  int availAmt;
  String imagePath;
  String transactionDate;

  List<Map<String, dynamic>> transactionList;

  TransactionDataModel({
    required this.id,
    required this.name,
    required this.mob,
    required this.availAmt,
    required this.imagePath,
    required this.transactionDate,
    required this.transactionList,
  });

  static List<TransactionDataModel> getUserTransaction(
      List<Map<String, dynamic>> data) {
    return data
        .map<TransactionDataModel>((e) => TransactionDataModel.fromJson(e))
        .toList();
  }

  factory TransactionDataModel.empty() => TransactionDataModel.fromJson({});

  factory TransactionDataModel.fromJson(Map<String, dynamic> data) =>
      TransactionDataModel(
        id: data["id"] ?? 0,
        name: data["name"] ?? "",
        mob: data["mob"] ?? "",
        availAmt: data["availAmt"]?.toInt() ?? 0,
        imagePath: data["imagePath"] ?? "",
        transactionDate: data["transactionDate"] ?? "",
        transactionList: data["transactionList"] == null
            ? []
            : List<Map<String, dynamic>>.from(
                data["transactionList"].map((x) => x),
              ),
      );
}
