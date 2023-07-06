import 'dart:async';
import 'dart:developer';

import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';
import 'bloc_observer.dart';

Future<void> bootstrap() async {
  Bloc.observer = MyBlocObserver();

  final Box<Token> tokenBox = await Hive.openBox(TokenRepository.storageKeyName);

  final TokenRepository tokenRepository = TokenRepository(box: tokenBox);

  final DioServices dioServices = DioServices(tokenRepository: tokenRepository);

  final authApiClient = AuthenticationApiClientImpl(dio: dioServices.getDio());
  final userAuthClient = UserApiClientImpl(dio: dioServices.getDio());
  final auctionApiClient = AuctionApiClientImpl(dio: dioServices.getDio());
  final bidApiClient = BidApiClientImpl(dio: dioServices.getDio());
  final itemApiClient = ItemApiClientImpl(dio: dioServices.getDio());

  final AuthenticationRepository authenticationRepository = AuthenticationRepository(apiClient: authApiClient);
  final UserRepository userRepository = UserRepository(apiClient: userAuthClient);
  final AuctionRepository auctionRepository = AuctionRepository(apiClient: auctionApiClient);
  final BidRepository bidRepository = BidRepository(apiClient: bidApiClient);
  final ItemRepository itemRepository = ItemRepository(apiClient: itemApiClient);

  runZonedGuarded(
    () => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => dioServices),
          RepositoryProvider(create: (_) => authenticationRepository),
          RepositoryProvider(create: (_) => userRepository),
          RepositoryProvider(create: (_) => tokenRepository),
          RepositoryProvider(create: (_) => auctionRepository),
          RepositoryProvider(create: (_) => bidRepository),
          RepositoryProvider(create: (_) => itemRepository),
        ],
        child: const MyApp(),
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
