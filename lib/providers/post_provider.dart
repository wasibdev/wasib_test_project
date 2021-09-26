import 'dart:convert';
import 'dart:developer'as logging;
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:test_project/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/utils/api.dart';
import 'package:test_project/utils/config.dart';

class PostProvider with ChangeNotifier {
  late Post post;
  bool loading = false;

  getPost(context) async {
    loading = true;
    post = await fetchPost(context);
    loading = false;
    post.title.isNotEmpty?
    notifyListeners():null;
  }

  Future<Post> fetchPost(context) async {
    var url = Uri.parse(restUrl+posts+Random().nextInt(100).toString());
    Post res = Post(id: 0, userId: 0, title: '', body: '');
    try {
      final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        res = Post.fromJson(item);
      } else {
        showToast('post not found');
      }
    } catch (e) {
      logging.log(e.toString());
    }
    return res;
  }
}