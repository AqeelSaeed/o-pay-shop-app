// Enum to define bill types
enum BillType {
  electricity,
  water,
  gas,
  internet,
}

enum AlertType { system, account }

enum SystemAlertType { systemUpdate, maintenance, featureRelease }

enum AccountAlertType { depositRequest, withdrawalRequest, transferRequest }

enum TransactionType {
  withdraw,
  transfer,
  payBill,
  electricity,
  water,
  gas,
  internet,
}
