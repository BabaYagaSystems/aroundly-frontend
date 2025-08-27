import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/core/network/dio_client.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service_impl.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_api_service_impl_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late AuthApiServiceImpl authApiService;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    authApiService = AuthApiServiceImpl();
    
    // Setup service locator mock
    if (!sl.isRegistered<DioClient>()) {
      sl.registerLazySingleton<DioClient>(() => mockDioClient);
    }
  });

  group('AuthApiServiceImpl', () {
    group('login', () {
      test('should return UserEntity when login is successful with correct response format', () async {
        // Arrange - using the actual backend response format
        final responseData = {
          "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJzX2RFbjg4eEFZSm5LWFJ5cG12Y2xBNnJYTWE4VGZ3c28waHFkcW9HOThNIn0.eyJleHAiOjE3NTYzMDQ4OTYsImlhdCI6MTc1NjMwNDU5NiwianRpIjoiZjhjNjRjZjEtMTI2Mi00NTA3LThiM2ItZWI2NTYwY2FhYzVlIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo3MDgwL3JlYWxtcy9nbGltcHNlIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6ImIwZTY2MjFlLTNiZDktNDgxOS05NjJjLWMzMjg5OGFkZjY4YyIsInR5cCI6IkJlYXJlciIsImF6cCI6ImFyb3VuZGx5Iiwic2Vzc2lvbl9zdGF0ZSI6IjA4OGIzN2JmLTQxM2ItNGY2Ny1iYTdhLWI4NjI4NWEyY2ZmNSIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiaHR0cDovL2xvY2FsaG9zdDo4MTAwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsImRlZmF1bHQtcm9sZXMtZ2xpbXBzZSIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwic2lkIjoiMDg4YjM3YmYtNDEzYi00ZjY3LWJhN2EtYjg2Mjg1YTJjZmY1IiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ2YXNpbGUxMjMiLCJlbWFpbCI6InZhc2lsZUBnbWFpbC5jb20ifQ.lBOyDqE0y2BnU4fWXG7g9GQ8REnBIxno_UJ6_ijCGDrqazLO9aqsefhsO7kDZO3CwYBDQNocnW0EsDAwmWVErqMjeLGa4ZLwCj_sqYyK5rMxeZ-_Sjhzjub5fau2DpCvn9IoC7ro6SxoHiiu1OPkn0PPQ0X9KQVSsHOhvaxGiahtSGGYcnFNfeJ2813j9FykwE42144ZlG-GN3vLVjj7EdYM0aeeeq_pF1GwDAVbdte4AMmh7_seYAyVY6aZ4dLb7aStMmemgIwi-jdSehGa45ESAWGsFKBmh--uy7cerVAsDBTGx-_jpOaYvqJI7_35LVX262uA0NTG55-U1uyaAA",
          "tokenType": "Bearer",
          "expiresIn": 300,
          "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI5MzQzMjFiMi00ZjljLTQ2NDktYTA2NS02NGRlNDA5Mzc1ZWYifQ.eyJleHAiOjE3NTYzMDYzOTYsImlhdCI6MTc1NjMwNDU5NiwianRpIjoiNjBmNDliMWEtNDE0Mi00OWQ4LWI0ZTAtNDRjNGJjMmI3YzAxIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo3MDgwL3JlYWxtcy9nbGltcHNlIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo3MDgwL3JlYWxtcy9nbGltcHNlIiwic3ViIjoiYjBlNjYyMWUtM2JkOS00ODE5LTk2MmMtYzMyODk4YWRmNjhjIiwidHlwIjoiUmVmcmVzaCIsImF6cCI6ImFyb3VuZGx5Iiwic2Vzc2lvbl9zdGF0ZSI6IjA4OGIzN2JmLTQxM2ItNGY2Ny1iYTdhLWI4NjI4NWEyY2ZmNSIsInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsInNpZCI6IjA4OGIzN2JmLTQxM2ItNGY2Ny1iYTdhLWI4NjI4NWEyY2ZmNSJ9.4q5RTD4rtIEQ8DsOr6DtextL_jrfgm-N0be6ezQRmLU",
          "username": "vasile123",
          "email": "vasile@gmail.com"
        };

        final response = Response<Map<String, dynamic>>(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final loginReq = LoginReqParams(
          usernameOrEmail: 'vasile@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.login(loginReq);

        // Assert
        expect(result.isRight(), true);
        final user = result.getOrElse(() => throw Exception('Should not reach here'));
        
        expect(user.username, 'vasile123');
        expect(user.email, 'vasile@gmail.com');
        expect(user.accessToken, responseData['accessToken']);
      });

      test('should return ServerError when accessToken field is missing', () async {
        // Arrange - missing accessToken field
        final responseData = {
          "username": "vasile123",
          "email": "vasile@gmail.com",
          // accessToken is missing
        };

        final response = Response<Map<String, dynamic>>(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final loginReq = LoginReqParams(
          usernameOrEmail: 'vasile@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.login(loginReq);

        // Assert
        expect(result.isLeft(), true);
        final error = result.fold((l) => l, (r) => throw Exception('Should not reach here'));
        expect(error, isA<ServerError>());
        expect((error as ServerError).message, contains('missing required fields'));
      });

      test('should return ServerError when username field is missing', () async {
        // Arrange - missing username field
        final responseData = {
          "accessToken": "test-token",
          "email": "vasile@gmail.com",
          // username is missing
        };

        final response = Response<Map<String, dynamic>>(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final loginReq = LoginReqParams(
          usernameOrEmail: 'vasile@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.login(loginReq);

        // Assert
        expect(result.isLeft(), true);
        final error = result.fold((l) => l, (r) => throw Exception('Should not reach here'));
        expect(error, isA<ServerError>());
        expect((error as ServerError).message, contains('missing required fields'));
      });

      test('should return ServerError when email field is missing', () async {
        // Arrange - missing email field
        final responseData = {
          "accessToken": "test-token",
          "username": "vasile123",
          // email is missing
        };

        final response = Response<Map<String, dynamic>>(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final loginReq = LoginReqParams(
          usernameOrEmail: 'vasile@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.login(loginReq);

        // Assert
        expect(result.isLeft(), true);
        final error = result.fold((l) => l, (r) => throw Exception('Should not reach here'));
        expect(error, isA<ServerError>());
        expect((error as ServerError).message, contains('missing required fields'));
      });

      test('should return ServerError when response data is null', () async {
        // Arrange
        final response = Response<Map<String, dynamic>>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final loginReq = LoginReqParams(
          usernameOrEmail: 'vasile@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.login(loginReq);

        // Assert
        expect(result.isLeft(), true);
        final error = result.fold((l) => l, (r) => throw Exception('Should not reach here'));
        expect(error, isA<ServerError>());
        expect((error as ServerError).message, contains('data is null or not a map'));
      });

      test('should return ServerError when any field is null', () async {
        // Arrange - accessToken is null
        final responseData = {
          "accessToken": null,
          "username": "vasile123",
          "email": "vasile@gmail.com",
        };

        final response = Response<Map<String, dynamic>>(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/login'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final loginReq = LoginReqParams(
          usernameOrEmail: 'vasile@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.login(loginReq);

        // Assert
        expect(result.isLeft(), true);
        final error = result.fold((l) => l, (r) => throw Exception('Should not reach here'));
        expect(error, isA<ServerError>());
        expect((error as ServerError).message, contains('one or more fields are null'));
      });
    });

    group('register', () {
      test('should return UserEntity when register is successful with correct response format', () async {
        // Arrange - using the same format as login (backend likely returns same structure)
        final responseData = {
          "accessToken": "test-access-token",
          "tokenType": "Bearer",
          "expiresIn": 300,
          "refreshToken": "test-refresh-token",
          "username": "newuser123",
          "email": "newuser@gmail.com"
        };

        final response = Response<Map<String, dynamic>>(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/register'),
        );

        when(mockDioClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);

        final registerReq = RegisterReqParams(
          username: 'newuser123',
          email: 'newuser@gmail.com',
          password: 'password123',
        );

        // Act
        final result = await authApiService.register(registerReq);

        // Assert
        expect(result.isRight(), true);
        final user = result.getOrElse(() => throw Exception('Should not reach here'));
        
        expect(user.username, 'newuser123');
        expect(user.email, 'newuser@gmail.com');
        expect(user.accessToken, 'test-access-token');
      });
    });
  });
}