import 'dart:convert';

class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String? publisher;
  final String? publishedDate;
  final String description;
  final int pageCount;
  final String language;
  final Map<String, dynamic> imageLinks;
  final String previewLink;
  final String infoLink;
  final bool isFavourite;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.publisher,
    this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.language,
    required this.imageLinks,
    required this.previewLink,
    required this.infoLink,
    this.isFavourite = false,
  });

  /// ✅ Google Books API → Model
  factory Book.fromApiJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'No Title',
      authors: volumeInfo['authors'] != null
          ? List<String>.from(volumeInfo['authors'])
          : ['Unknown'],
      publisher: volumeInfo['publisher'],
      publishedDate: volumeInfo['publishedDate'],
      description: volumeInfo['description'] ?? 'No description available',
      pageCount: volumeInfo['pageCount'] ?? 0,
      language: volumeInfo['language'] ?? '',
      imageLinks: volumeInfo['imageLinks'] ?? {},
      previewLink: volumeInfo['previewLink'] ?? '',
      infoLink: volumeInfo['infoLink'] ?? '',
      isFavourite: false,
    );
  }

  /// ✅ DB → Model
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      authors: List<String>.from(jsonDecode(json['authors'])),
      publisher: json['publisher'],
      publishedDate: json['publishedDate'],
      description: json['description'],
      pageCount: json['pageCount'],
      language: json['language'],
      imageLinks: jsonDecode(json['imageLinks']),
      previewLink: json['previewLink'],
      infoLink: json['infoLink'],
      isFavourite: json['isFavourite'] == 1,
    );
  }

  /// ✅ Model → DB
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': jsonEncode(authors),
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'pageCount': pageCount,
      'language': language,
      'imageLinks': jsonEncode(imageLinks),
      'previewLink': previewLink,
      'infoLink': infoLink,
      'isFavourite': isFavourite ? 1 : 0,
    };
  }

  @override
  String toString() {
    return "Book: $title";
  }
}
