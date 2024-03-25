import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/api/bloc/api_bloc.dart';
import 'package:fluttertest/api/bloc/api_event.dart';
import 'package:fluttertest/api/bloc/api_state.dart';
import 'package:fluttertest/api/utils.dart/enum.dart';

class HomepageApi extends StatefulWidget {
  const HomepageApi({super.key});

  @override
  State<HomepageApi> createState() => _HomepageApiState();
}

class _HomepageApiState extends State<HomepageApi> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ApisBloc>().add(PostfetchEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ApisBloc, ApisState>(
      builder: (context, state) {
 switch(state.poststatus){
            case Poststatus.failure :
            return Text('error');
            case Poststatus.loading:
            return CircularProgressIndicator();
            case Poststatus.success:
            print(state.postlist);
          
print('object');
        return Text('succes');
      }}
    ));
  }
}
