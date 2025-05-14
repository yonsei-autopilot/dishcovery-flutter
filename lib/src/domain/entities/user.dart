class User {
  final String? id;
  final String? email;
  final String? imageUrl;

  User({this.id, this.email, this.imageUrl});

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'imageUrl': imageUrl
  };

  factory User.fromJson(Map<String, dynamic> json) => User (
    id: json['id'] as String,
    email: json['email'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}