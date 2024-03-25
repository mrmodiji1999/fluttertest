

import 'dart:convert';
import 'dart:io';

import 'package:fluttertest/api/model/mode.dart';
import 'package:http/http.dart'as http;
class Postrepo{
  Future<List<CommentModel>> fetchpost()async{
    try{
     final url=Uri.parse('https://jsonplaceholder.typicode.com/comments');
    final response =await http.get(url);
    if(response.statusCode == 200)
    {
      final body= json.decode(response.body)as List;
    return body.map((e) {
      return CommentModel(
        postId : e['postId'] as int,
        email:e['email'] as String,
        body: e['body'] as String,


      );
    }).toList();
    }
  
    }on SocketException{
      throw Exception('error ob url');
    }
    
 throw Exception('error on fetching dtata');
  }
}