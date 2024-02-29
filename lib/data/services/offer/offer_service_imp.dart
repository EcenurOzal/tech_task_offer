import 'package:fpdart/fpdart.dart';

import '../../../core/exception/exception.dart';
import '../../../core/network/app_network.dart';
import '../../../feature/home/model/loan_model.dart';
import '../../../feature/home/model/offers_response.dart';
import 'offer_service.dart';

class OfferServiceImp extends OfferService {
  OfferServiceImp(super.apiHelper);

  @override
  Future<Either<NetworkException, OffersResponse>> getOffers(
    LoanModel loanModel,
  ) async {
    final response = await apiHelper.request(
      HttpMethod.get,
      '/getLoanOffers',
      queryParameters: {
        "kredi_tipi": loanModel.loanType.value,
        "vade": loanModel.defaultMaturity,
        "tutar": loanModel.defaultAmount,
        if (loanModel.carType != null) "arabaTuru": loanModel.carType?.value,
      },
    );

    return response.fold(
      (l) => left(l),
      (r) => right(
        r.data != null
            ? OffersResponse.fromJson(r.data as Map<String, dynamic>)
            : OffersResponse(),
      ),
    );
  }
}
