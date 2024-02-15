part of 'ideas_bloc.dart';

@immutable
sealed class IdeasEvent {}
final class OnIdeasRead extends IdeasEvent{


  OnIdeasRead();
}
final class OnIdeasDelete extends IdeasEvent{
  int id;

  OnIdeasDelete({ required this.id});
}
final class OnIdeasEdit extends IdeasEvent{
  IdeasModel idea;
  OnIdeasEdit({required this.idea});

}
final class OnIdeasCreate extends IdeasEvent{
  IdeasModel idea;
  OnIdeasCreate({required this.idea});
}