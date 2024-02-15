
part of 'ideas_bloc.dart';

@immutable
sealed class IdeasState {}

class IdeasInitial extends IdeasState {}
class IdeasSucsses extends IdeasState{
 final String ideasSucsses;
 List<IdeasModel> ideas=[];
 IdeasSucsses( this.ideasSucsses,this.ideas);

}
class IdeasFailed extends IdeasState{
  final String error;

  IdeasFailed(this.error);

}
class IdeasLoading extends IdeasState{}
