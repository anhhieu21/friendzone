import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friendzone/src/data/repositories/reel_repository.dart';
import 'package:friendzone/src/domain/models/reel.dart';

part 'reel_state.dart';

class ReelCubit extends Cubit<ReelState> {
  final ReelRepository _reelRepository;
  ReelCubit(this._reelRepository) : super(ReelInitial()) {
    getReels();
  }

  getReels() async {
    final list = await _reelRepository.getReels();
    emit(AllReel(list));
  }
}
