part of 'reel_cubit.dart';

class ReelState extends Equatable {
  const ReelState();

  @override
  List<Object> get props => [];
}

class ReelInitial extends ReelState {}

class AllReel extends ReelState {
  final List<Reel> list;
  const AllReel(this.list);

  @override
  List<Object> get props => [list];
}
