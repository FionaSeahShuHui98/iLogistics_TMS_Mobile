class FcmPayLoad {
  // Declaration
  static const _title = 'title';
  static const _body = 'body';
  static const _imageUrl = 'image';
  final String title;
  final String body;
  final String? imageUrl;
  FcmPayLoad({required this.title, required this.body, this.imageUrl});

  // Linking Declaraiton to Codes
  Map<String, dynamic> get toMap =>
      {_title: title, _body: body, _imageUrl: imageUrl};

  // Receive Data from Server
  factory FcmPayLoad.fromJson(json) {
    return FcmPayLoad(title: json[_title], body: json[_body]);
  }
}
