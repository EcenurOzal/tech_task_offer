import 'package:fpdart/fpdart.dart';

import '../../../core/exception/exception.dart';
import '../../../core/network/app_network.dart';
import '../../../feature/home/model/loan_model.dart';
import '../../../feature/home/model/offers_response.dart';

abstract class OfferService {
  final ApiHelper apiHelper;

  //? Constructor
  OfferService(this.apiHelper);

  //? Abstract methods
  Future<Either<NetworkException, OffersResponse>> getOffers(
    LoanModel loanModel,
  );
}
