class InventoryItem {
  int? id;
  String? name;
  String? store;
  int? timing;
  double? price;
  String? url;

  InventoryItem({this.id, this.name, this.store, this.timing, this.price, this.url});

  // Convert an InventoryItem object to a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'store': store,
      'timing': timing,
      'price': price,
      'url': url,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Convert a Map object to an InventoryItem object
  InventoryItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    store = map['store'];
    timing = map['timing'];
    price = map['price'];
    url = map['url'];
  }
}
