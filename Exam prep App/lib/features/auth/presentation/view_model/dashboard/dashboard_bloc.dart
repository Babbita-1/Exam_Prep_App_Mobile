import 'package:bloc/bloc.dart';
import 'package:exam_prep/features/auth/presentation/view_model/dashboard/dashboard_event.dart';
import 'package:exam_prep/features/auth/presentation/view_model/dashboard/dashboard_state.dart';

// Importing necessary files

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardTabChanged>((event, emit) {
      emit(DashboardLoaded(event.index));
    });
  }
}
