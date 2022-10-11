import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit() : super(MyPostsInitial());
}
