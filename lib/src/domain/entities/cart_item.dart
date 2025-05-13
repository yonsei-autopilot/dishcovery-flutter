class CartItem {
  final String menuName;
  final int count;
  final String imageUrl;

  CartItem({required this.menuName, required this.count, required this.imageUrl});

  Map<String, dynamic> toJson() => {'menuName': menuName, 'count': count, 'imageUrl': imageUrl};

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      CartItem(menuName: json['menuName'], count: json['count'], imageUrl: json['imageUrl']);

  CartItem copyWith({
    String? menuName,
    int? count,
    String? imageUrl,
  }) {
    return CartItem(
      menuName: menuName ?? this.menuName,
      count: count ?? this.count,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}