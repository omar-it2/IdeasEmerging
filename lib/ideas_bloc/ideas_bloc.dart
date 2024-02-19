
import 'package:emergingideas/repository/repository_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/ideas_model.dart';

part 'ideas_event.dart';
part 'ideas_state.dart';

class IdeasBloc extends Bloc<IdeasEvent, IdeasState> {
  IdeasBloc() : super(IdeasInitial()) {
    on<OnIdeasRead>(_onGEtRequested);
    on<OnIdeasDelete>(_onDeleteRequested);
    on<OnIdeasEdit>(_onEditRequested);
    on<OnIdeasCreate>(_onCreateRequested);
  }
}
IdeasRepository ideasRepository=IdeasRepository();
void _onGEtRequested(
    OnIdeasRead event,
    Emitter<IdeasState> emit,
    ) async {
  emit(IdeasLoading());
  try {
    List<IdeasModel> ideas=[];
    ideas=await ideasRepository.getIdeas();
    emit(IdeasSucsses("Sucsses",ideas));



  } catch (e) {
    return emit(IdeasFailed(e.toString()));
  }
}

void _onDeleteRequested(
    OnIdeasDelete event,

    Emitter<IdeasState> emit,
    ) async {
  emit(IdeasLoading());
  try {
    await ideasRepository.deleteIdeas(event.id );
    List<IdeasModel> ideas=[];
    ideas=await ideasRepository.getIdeas();
    emit(IdeasSucsses("Sucsses",ideas));

  } catch (e) {
    emit(IdeasFailed(e.toString()));
  }
}
void _onEditRequested(OnIdeasEdit event,
Emitter<IdeasState> emit,
)async{
  emit(IdeasLoading());
  try {
    await ideasRepository.editeIdeas(event.idea );
    List<IdeasModel> ideas=[];
    ideas=await ideasRepository.getIdeas();
    emit(IdeasSucsses("Sucsses",ideas));

  } catch (e) {
    emit(IdeasFailed(e.toString()));
  }

}
void _onCreateRequested(OnIdeasCreate event,
    Emitter<IdeasState> emit,
    )async{
  emit(IdeasLoading());
  try {
    await ideasRepository.createIdeas(event.idea );
    List<IdeasModel> ideas=[];
    ideas=await ideasRepository.getIdeas();
    emit(IdeasSucsses("Sucsses",ideas));

  } catch (e) {
    emit(IdeasFailed(e.toString()));
  }

}
