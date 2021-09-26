import 'dart:convert';
import 'dart:developer'as logging;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/models/post_model.dart';
import 'package:test_project/utils/api.dart';
import 'package:test_project/utils/config.dart';

class PostProvider with ChangeNotifier {
  Post post = Post(id: 0, userId: 0, title: '', body: '');
  bool loading = false;

  getPost(context,id) async {
    loading = true;
    post = await fetchPost(context,id);
    loading = false;
    notifyListeners();
  }

  Future<Post> fetchPost(context,id) async {
    var url = Uri.parse(restUrl+posts+"/"+id);
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
        logging.log(response.body);
      } else {
        logging.log(response.body);
        showToast('post not found');
      }
    } catch (e) {
      logging.log(e.toString());
    }
    return res;
  }
}