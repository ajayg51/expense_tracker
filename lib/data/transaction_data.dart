import 'package:expense_tracker/utils/assets.dart';

//  toBeReceived => type expense
//      (senderId != receiverId and
//      take care of below point while entry
//      type income not exists for that receiverId)
//  myExpenses => type expense (senderId == receiverId)

//  toBePaid => type income (senderId != receiverId)

class TransactionData {
  static List<Map<String,dynamic>> allTransactionList = <Map<String, dynamic>>[
    {
      "id": 1,
      "name": "Alice",
      "mob": "+91120",
      "availAmt": 12345,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 3,
          "receiverId": 1,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
        {
          "type": "income",
          "senderId": 1,
          "receiverId": 1,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
        {
          "type": "expense",
          "senderId": 1,
          "receiverId": 1,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
        {
          "type": "expense",
          "senderId": 1,
          "receiverId": 3,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
        {
          "type": "income",
          "senderId": 2,
          "receiverId": 1,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 2,
      "name": "Bob",
      "mob": "+911234567890",
      "availAmt": 1345,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "expense",
          "senderId": 2,
          "receiverId": 1,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
        {
          "type": "income",
          "senderId": 2,
          "receiverId": 2,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 3,
      "name": "Charles",
      "mob": "+911234567890",
      "availAmt": 2345,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 1,
          "receiverId": 3,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 4,
      "name": "Dobby",
      "mob": "+911234567890",
      "availAmt": 1245,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 4,
          "receiverId": 4,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 5,
      "name": "Eliza",
      "mob": "+911234567890",
      "availAmt": 1235,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 5,
          "receiverId": 5,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 6,
      "name": "Felish",
      "mob": "+911234567890",
      "availAmt": 345,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 6,
          "receiverId": 6,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 7,
      "name": "Goblin",
      "mob": "+911234567890",
      "availAmt": 1245,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 7,
          "receiverId": 7,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 8,
      "name": "Hellen",
      "mob": "+911234567890",
      "availAmt": 12357,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 8,
          "receiverId": 8,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 9,
      "name": "Iraa",
      "mob": "+911234567890",
      "availAmt": 345543,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 9,
          "receiverId": 9,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    },
    {
      "id": 10,
      "name": "Jack",
      "mob": "+911234567890",
      "availAmt": 124523,
      "imagePath": Assets.dummyUserImg,
      "transactionList": <Map<String, dynamic>>[
        {
          "type": "income",
          "senderId": 10,
          "receiverId": 10,
          "amt": 12,
          "transactionDate": "2023-11-26 20:33:45.776847",
        },
      ],
    }
  ];
}
