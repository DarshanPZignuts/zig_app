import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zig_project/bloc/api_constants.dart';
import 'package:zig_project/bloc/network_cubit.dart';
import 'package:zig_project/model/response/model_random_user.dart';

class RandomUserController with ChangeNotifier {
  NetworkCubit? networkCubit;
  getRandomUser() async {
    Response? response;
    response =
        await networkCubit!.networkGetRequest(APIConstants.baseURL, Map());

    if (response != null && response.statusCode == 200) {
      ModelRandomUser randomUser =
          ModelRandomUser.fromJson(jsonDecode(response.body));
      return randomUser;
    } else {
      return null;
    }
  }
}
