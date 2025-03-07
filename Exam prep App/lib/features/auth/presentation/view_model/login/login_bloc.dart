import 'package:equatable/equatable.dart';
import 'package:exam_prep/features/auth/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/snackbar/snackbar.dart';
import '../../../../home/presentation/view_model/home_cubit.dart';
import '../../../domain/use_case/login_user_usecase.dart';
import '../signup/register_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUserUsecase _loginUserUsecase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUserUsecase loginUserUsecase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUserUsecase = loginUserUsecase,
        super(LoginState.initial()) {
    // Navigate to Register Screen
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _registerBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    // Navigate to Home Screen (Previously used in Login)
    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });

    // Toggle password visibility
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    // Handle Login Event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final params = LoginUserParams(
        email: event.email,
        password: event.password,
      );

      final result = await _loginUserUsecase.call(params);

      result.fold(
        (failure) {
          // If login fails, show error message
          String errorMessage = failure.message;

          emit(state.copyWith(isLoading: false, isSuccess: false));

          showMySnackBar(
            context: event.context,
            message: 'Invalid Credentials: $errorMessage',
            color: Color(0xFF9B6763),
          );
        },
        (user) {
          // On success, update state
          emit(state.copyWith(isLoading: false, isSuccess: true));

          // Navigate to DashboardView instead of HomeView
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(builder: (context) => DashboardView()),
          );
        },
      );
    });
  }
}
