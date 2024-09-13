class PostModel {
  // Fields are made final for immutability
  final num userId;
  final num id;
  final String title;
  final String body;

  // Constructor with required named parameters
  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory method to create a PostModel from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Method to copy the PostModel object with new values
  PostModel copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) {
    return PostModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
