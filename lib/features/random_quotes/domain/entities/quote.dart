// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String auther;
  final int id;
  final String content;
  final String permalink;

  const Quote({
    required this.auther,
    required this.id,
    required this.content,
    required this.permalink,
  });

  @override
  List<Object> get props => [auther, id, content, permalink];
}
