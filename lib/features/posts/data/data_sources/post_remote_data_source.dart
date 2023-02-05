import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/constans/constants.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(postsBaseUrl + postsEndPoint),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body) as List;
      List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final postBody = {"title": postModel.postTitle, "body": postModel.postBody};
    final response = await client.post(Uri.parse(postsBaseUrl + postsEndPoint),
        body: postBody);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$postsBaseUrl$postsEndPoint${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.postId.toString();
    final postBody = {"title": postModel.postTitle, "body": postModel.postBody};
    final response = await client.patch(
        Uri.parse("$postsBaseUrl$postsEndPoint$postId"),
        body: postBody);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
