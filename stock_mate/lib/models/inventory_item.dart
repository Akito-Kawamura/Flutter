class InventoryItem {
  int? id;
  String name;
  String? purchasePlace;
  double? price;
  int timing;
  String? onlineStoreUrl;
  int updateDate;
  int nextPurchaseDate;

  InventoryItem({
    this.id,
    required this.name,
    this.purchasePlace,
    this.price,
    required this.timing,
    this.onlineStoreUrl,
    required this.updateDate,
    required this.nextPurchaseDate,
  });

  // Mapからインスタンスを生成するファクトリメソッド
  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      id: map['id'],
      name: map['name'],
      purchasePlace: map['purchasePlace'],
      price: map['price'],
      timing: map['timing'],
      onlineStoreUrl: map['onlineStoreUrl'],
      updateDate: map['updateDate'],
      nextPurchaseDate: map['nextPurchaseDate'],
    );
  }

  // インスタンスをMapに変換するメソッド
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'purchasePlace': purchasePlace,
      'price': price,
      'timing': timing,
      'onlineStoreUrl': onlineStoreUrl,
      'updateDate': updateDate,
      'nextPurchaseDate': nextPurchaseDate,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
