import 'package:bloc/bloc.dart';
import 'package:news_app/shared/bloc/states.dart';

class AppCubit extends Cubit<NewsStates> {
  AppCubit() : super(NewsInitialState());
}