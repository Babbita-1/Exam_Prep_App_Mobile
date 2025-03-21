import 'package:dartz/dartz.dart';
import 'package:exam_prep/core/error/failure.dart';
import 'package:exam_prep/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUserUsecase useCase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUserUsecase(
        userRepository: repository, tokenSharedPrefs: tokenSharedPrefs);

    // Register fallback values for mocked objects
    registerFallbackValue(
        LoginUserParams(email: 'bista@gmail.com', password: '123456790'));
  });

  test(
      'should call the [AuthRepo.login] with correct email and password (bista@gmail.com, 123456790)',
      () async {
    when(() => repository.login(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'bista@gmail.com' && password == '123456790') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(
              Left(ApiFailure(message: 'Invalid email or password')));
        }
      },
    );

    when(() => tokenSharedPrefs.saveToken(any())).thenAnswer(
      (_) async => Right(null),
    );

    final result = await useCase(
        LoginUserParams(email: 'bista@gmail.com', password: '123456790'));

    expect(result, const Right('token'));

    verify(() => repository.login(any(), any())).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  test('should return a token when login is successful', () async {
    const email = 'bista@gmail.com';
    const password = '123456790';
    const token = 'mock_token';
    final loginParams = LoginUserParams(email: email, password: password);

    when(() => repository.login(any(), any()))
        .thenAnswer((_) async => Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => Right(null));

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => Future.value(Right(token)));

    final result = await useCase(loginParams);

    expect(result, Right(token));

    verify(() => repository.login(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(token)).called(1);
    // verify(() => tokenSharedPrefs.getToken()).called(1);
  });

  // test('should return a failure when login fails', () async {
  //   const email = 'wrong@gmail.com';
  //   const password = 'wrongPass';
  //   final loginParams = LoginUserParams(email: email, password: password);
  //
  //   when(() => repository.login(any(), any()))
  //       .thenAnswer((_) async => Left(ApiFailure(message: "Invalid login")));
  //
  //   final result = await useCase(loginParams);
  //
  //   expect(result, Left(ApiFailure(message: "Invalid login")));
  //
  //   verify(() => repository.login(email, password)).called(1);
  //   verifyNever(() => tokenSharedPrefs.saveToken(any()));
  // });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
