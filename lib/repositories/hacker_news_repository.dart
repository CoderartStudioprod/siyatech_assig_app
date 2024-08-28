import 'dart:convert';
import 'package:dio/dio.dart';
import '../Model/post.dart';

class HackerNewsRepository {
  final Dio dio;

  HackerNewsRepository({Dio? dio}) : dio = dio ?? Dio();

  Future<List<int>> fetchTopStoryIds() async {
    final response = await dio.get(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');
    if (response.statusCode != 200)
      throw Exception('Failed to load top story IDs');
    return List<int>.from(response.data);
  }

  Future<Post> fetchPost(int id) async {
    final response = await dio.get(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
    if (response.statusCode != 200) throw Exception('Failed to load post');
    return Post.fromJson(response.data);
  }
}
