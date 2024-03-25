import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddTodoPage extends StatefulWidget {
  final Map? edititem;
  const AddTodoPage({super.key, this.edititem});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titiecontroler = TextEditingController();
  
  TextEditingController descriptioncontroler = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.edititem);
    if(widget.edititem != null){
      isEdit = true;
    final title = widget.edititem?['title'];
    titiecontroler.text = title;
    final description = widget.edititem?['description'];
    descriptioncontroler.text = description;
    }
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit?'edit page':'todo page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(controller: titiecontroler
          
          ,decoration: 
          InputDecoration(
            hintText: 'title'),),
           TextField(controller: descriptioncontroler,decoration:
            InputDecoration(hintText: 'Description'),
            maxLines: 5,),
       
          Padding(
            padding: const EdgeInsets.only(top:32.0),
            child: FilledButton(onPressed:      isEdit?updatedata:  submitdata, child: Text(isEdit?'update':'Submit'),),
          ),
          
          ],
      ),
    );
  }
  Future<void> submitdata()async{

    final titlee = titiecontroler.text;
    final descriptieon = descriptioncontroler.text;

final bod={
  "title": titlee,
  "description": descriptieon,
  "is_completed": false,
};
final url='https://api.nstack.in/v1/todos';
final response = await  http.post(Uri.parse(url,)
,body:jsonEncode(bod) ,headers:{'Content-Type':'application/json'} );
if(response.statusCode  == 201){
      titiecontroler.clear();
    descriptioncontroler.clear();
  snacbar('got success');
print(response.statusCode);
print(response.body);}else{ 
  snacbar('we failed');
  print('error');
  print(response.statusCode);
}
  }
  Future<void> updatedata()async{
if(widget.edititem == null)
{
 snacbar('toco data is empty');
 Navigator.pop(context);
}
final id = widget.edititem?['_id'];
print(id);
    final titlee = titiecontroler.text;
    final descriptieon = descriptioncontroler.text;

final bod={

  "title": titlee,
  "description": descriptieon,
  "is_completed": false,
};
final url='https://api.nstack.in/v1/todos/$id';
final response = await  http.put(Uri.parse(url,)
,body:jsonEncode(bod) ,headers:{'Content-Type':'application/json'} );
if(response.statusCode  == 200){
      titiecontroler.clear();
    descriptioncontroler.clear();
  snacbar('got update');
 
print(response.statusCode);
print(response.body);}else{ 
  snacbar('didn\'t update failed');
  print('error');
  print(response.statusCode);
}
  }


  void snacbar(String message){
    final snakbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }

}
