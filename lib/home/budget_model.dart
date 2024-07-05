class BudgetModel {
  String? name;
  String? category;
  String? categoryImg;
  int? type;
  double? amount;
  String? date;
  int? userId;

  BudgetModel({
    this.name,
    this.category,
    this.categoryImg,
    this.type,
    this.amount,
    this.date,
    this.userId,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
    name: json["name"],
    category: json["category"],
    categoryImg: json["category_img"],
    type: json["type"],
    amount: json["amount"]?.toDouble(),
    date: json["date"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "category": category,
    "category_img": categoryImg,
    "type": type,
    "amount": amount,
    "date": date,
    "user_id": userId,
  };
}
