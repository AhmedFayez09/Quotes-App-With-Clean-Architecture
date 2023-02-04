import 'package:quotes_app/features/random_quotes/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required super.auther,
    required super.id,
    required super.content,
    required super.permalink,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      auther: json['author'],
      id: json['id'],
      content: json['quote'],
      permalink: json['permalink'],
    );
  }

  Map<String, dynamic> toJson() => {
        'author': auther,
        'id': id,
        'quote': content,
        'permalink': permalink,
      };
}
