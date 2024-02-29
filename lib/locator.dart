import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/app_network.dart';
import 'data/repository/offer_repository.dart';
import 'data/services/offer/offer_service.dart';
import 'data/services/offer/offer_service_imp.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  BaseOptions options = BaseOptions(
    baseUrl: 'https://api2.teklifimgelsin.com/api/',
  );

  //!services
  getIt.registerLazySingleton<OfferService>(
    () => OfferServiceImp(
      ApiHelper(options),
    ),
  );

  //!repositories
  getIt.registerLazySingleton<OfferRepository>(
    () => OfferRepository(getIt<OfferService>()),
  );
}
