import 'dart:convert';

class InventoryItem {
  int? id;
  String name;
  String? store;
  String timing;
  int? price;
  String? url;

  InventoryItem({
    this.id,
    required this.name,
    this.store,
    required this.timing,
    this.price,
    this.url,
  });

  factory InventoryItem.fromMap(Map<String, dynamic> json) => InventoryItem(
        id: json["id"],
        name: json["name"],
        store: json["store"],
        timing: json["timing"],
        price: json["price"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "store": store,
        "timing": timing,
        "price": price,
        "url": url,
      };

  factory InventoryItem.fromJson(String source) =>
      InventoryItem.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
