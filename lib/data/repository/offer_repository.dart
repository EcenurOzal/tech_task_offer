import 'package:fpdart/fpdart.dart';

import '../../core/exception/exception.dart';
import '../../feature/home/model/loan_model.dart';
import '../../feature/home/model/offers_response.dart';
import '../services/offer/offer_service.dart';

class OfferRepository {
  final OfferService offerService;

  OfferRepository(this.offerService);

  Future<Either<NetworkException, OffersResponse>> getOffers(
      LoanModel loanModel) async {
    return offerService.getOffers(loanModel);
  }
}
