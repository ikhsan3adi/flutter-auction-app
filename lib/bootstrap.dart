import 'dart:async';
import 'dart:developer';

import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'bloc_observer.dart';

Future<void> bootstrap() async {
  Bloc.observer = MyBlocObserver();

  final Box<Token> tokenBox = await Hive.openBox(TokenRepository.storageKeyName);

  final TokenRepository tokenRepository = TokenRepository(box: tokenBox);

  final Dio dio = DioServices.createDio(tokenRepository: tokenRepository);

  final auctionApiClient = AuctionApiClientImpl(dio: dio);
  final authApiClient = AuthenticationApiClientImpl(dio: dio);

  final AuctionRepository auctionRepository = AuctionRepository(apiClient: auctionApiClient);
  final AuthenticationRepository authenticationRepository = AuthenticationRepository(apiClient: authApiClient);

  runZonedGuarded(
    () => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => tokenRepository),
          RepositoryProvider(create: (_) => auctionRepository),
          RepositoryProvider(create: (_) => authenticationRepository),
        ],
        child: const MyApp(),
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
