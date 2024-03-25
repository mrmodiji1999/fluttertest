import 'package:equatable/equatable.dart';
import 'package:fluttertest/api/utils.dart/enum.dart';
import 'package:fluttertest/model/usermodel.dart';

class ApisState extends Equatable {
  final Poststatus poststatus;
  final List<CommentModel> postlist;
  final String message;

  ApisState(
      { this.poststatus =Poststatus.loading,
       this.postlist =const <CommentModel>[],
     this.message = ''});

ApisState copyWith({Poststatus? poststatus,List<CommentModel>? postlist,String? message,}){
  return ApisState(
poststatus:poststatus ??this.poststatus,
postlist:postlist??this.postlist,
message:message??this.message

  );
}

  @override
  // TODO: implement props
  List<Object?> get props => [poststatus, postlist,message];
}
