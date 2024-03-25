import 'dart:convert';

import 'package:http/http.dart';
class UserRepo{
  String url = 'https://jsonplaceholder.typicode.com/posts';
  getuser ()async {
    Response response =await get(Uri.parse(url));
    if(response.statusCode == 200)
   { final List<dynamic>result  =  jsonDecode(response.body)['data'];}
  else{
    print( 'we got error');

  }
  }
 
}

