class CartItem {
  final String menuName;
  final int count;
  final String imageUrl;
  final List<String>? availableOptions;

  CartItem({
    required this.menuName,
    required this.count,
    required this.imageUrl,
    this.availableOptions,
  });

  Map<String, dynamic> toJson() => {
    'menuName': menuName,
    'count': count,
    'imageUrl': imageUrl,
    'availableOptions': availableOptions,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    menuName: json['menuName'],
    count: json['count'],
    imageUrl: json['imageUrl'],
    availableOptions: json['availableOptions'] != null
        ? List<String>.from(json['availableOptions'])
        : null,
  );

  CartItem copyWith({
    String? menuName,
    int? count,
    String? imageUrl,
    List<String>? availableOptions,
  }) {
    return CartItem(
      menuName: menuName ?? this.menuName,
      count: count ?? this.count,
      imageUrl: imageUrl ?? this.imageUrl,
      availableOptions: availableOptions ?? this.availableOptions,
    );
  }
}
