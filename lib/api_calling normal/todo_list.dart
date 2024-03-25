import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/api_calling%20normal/add_page.dart';
import 'package:fluttertest/user_repo.dart/api.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  bool isloding = true;
  List items = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchpost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: navigatorpage,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Todo App'),
        ),
        backgroundColor: Colors.grey,
        body: Visibility(
          visible: isloding == true,
          child: Center(
            child: CircularProgressIndicator(),
          ),
          replacement: RefreshIndicator(
            onRefresh: fetchpost,
            child: Visibility(
              visible: items.isEmpty,
             child : Center(child: Text('No data found',style: Theme.of(context).textTheme.displayLarge,)),
           replacement   :
               ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
              final id = item['_id'] as String;
                  return ListTile(
                    leading: Text('${index}'),
                    trailing: PopupMenuButton(onSelected: (value) {
                      if (value == 1) {
              navigatoreditpage(item);
                      } else if (value == 2){
              
              Delete(id);
                      } ;
                    }, itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: 2,
                        )
                      ];
                    }),
                    title: Text(
                      'item[title]',
                    ),
                    subtitle: Text(
                      item['description'],
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }

 Future <void> navigatorpage() async{
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
  await  Navigator.push(context, route);
  setState(() {
    isloding = true;
  });
  fetchpost();
  }
    Future<void> navigatoreditpage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(edititem:item),
    );
   await Navigator.push(context, route);
   setState(() {
     isloding=true;
   });
   fetchpost();
  }
  Future<void> Delete(String id)async{
    final Url ='https://api.nstack.in/v1/todos/$id';
    final url=Uri.parse(Url);
    final response =await http.delete(url);
if(response.statusCode == 200)
{    print(response.body);

print('deleteing the code');
snacbar('deleted');
fetchpost();
final filters = items.where((element) =>  element['id']!=id).toList();
setState(() {
  items=filters;
});
}

else{
  print('error');
  snacbar('got error');
}

  }

  Future<void> fetchpost() async {
    isloding = true;
    final Url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final url = Uri.parse(Url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final josn = jsonDecode(response.body) as Map;
      final result = josn["items"] as List;
      setState(() {
        items = result;

        isloding = false;
      });
    } else {
      print('are baba');
    }
  }  void snacbar(String message){
    final snakbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }
  
}
