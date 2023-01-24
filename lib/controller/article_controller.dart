import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zig_project/bloc/api_constants.dart';
import 'package:zig_project/bloc/network_cubit.dart';
import 'package:zig_project/model/response/model_article.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ArticleController with ChangeNotifier {
  NetworkCubit? networkCubit;

  ModelArticles? articles;

  Future<ModelArticles?> getArticle() async {
    Response? response;

    response = await get(Uri.parse(APIConstants.articleBaseURL));
    if (response.statusCode == 200) {
      ModelArticles modelArticles =
          ModelArticles.fromJson({"data": jsonDecode(response.body)});

      articles = modelArticles;

      return articles;
    }

    // response = await networkCubit!
    //     .networkGetRequest(APIConstants.articleBaseURL, Map());

    return null;
  }
}
