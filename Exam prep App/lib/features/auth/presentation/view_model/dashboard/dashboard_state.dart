import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int selectedIndex;
  const DashboardLoaded(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
