#!/bin/bash

echo "Installing dependencies..."
flutter pub get

echo "Generating mocks..."
dart run build_runner build --delete-conflicting-outputs

echo "Running authentication tests..."
flutter test test/features/auth/data/datasources/remote/auth_api_service_impl_test.dart

echo "Test execution completed!"