import 'package:bloc/bloc.dart';

import '../../../core/core.dart';
import '../../../data/repository/offer_repository.dart';
import '../model/model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.offerRepository,
  }) : super(
          const HomeState(),
        );

  final OfferRepository offerRepository;

  Future<void> init() async {
    final List<LoanModel> loans = [];

    //! Servisten geldği varsayılır ve burada eklenir.
    loans.addAll([
      AppConst.personalLoan,
      AppConst.vehicleLoan,
      AppConst.mortgageLoan,
    ]);

    emit(
      state.copyWith(
        loans: loans,
        selectedLoan: loans.first,
      ),
    );

    await getOffers();
  }

  Future<void> getOffers() async {
    emit(
      state.copyWith(
        event: HomeEvent.loading,
      ),
    );

    final result = await offerRepository.getOffers(
      state.selectedLoan!,
    );

    result.fold(
      (l) {
        //! Hata durumunda
        emit(
          state.copyWith(
            event: HomeEvent.failure,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            event: HomeEvent.success,
            offers: r,
            activeOffers: r.activeOffers,
            sponsoredOffers: r.sponsoredOffers,
          ),
        );
      },
    );
  }

  void setSelectedLoan(LoanModel selectedModel) {
    emit(
      state.copyWith(
        selectedLoan: selectedModel,
      ),
    );
  }

  void setSliderAmount(int amount) {
    final LoanModel temp;

    //? İhtiyaç kredisi için özel durum
    if (state.selectedLoan!.loanType == LoanType.personalLoan) {
      if (amount >= 100000) {
        temp = state.selectedLoan!.copyWith(
            maxMaturity: 12,
            defaultMaturity: 12,
            minMaturity: 1,
            defaultAmount: amount);
      } else {
        temp = state.selectedLoan!.copyWith(
          defaultAmount: amount,
          maxMaturity: 36,
          defaultMaturity: 6,
          minMaturity: 1,
        );
      }
    } else {
      temp = state.selectedLoan!.copyWith(defaultAmount: amount);
    }

    emit(
      state.copyWith(
        selectedLoan: temp,
      ),
    );
  }

  void setSliderMaturity(int maturity) {
    final temp = state.selectedLoan!.copyWith(defaultMaturity: maturity);
    emit(
      state.copyWith(
        selectedLoan: temp,
      ),
    );
  }

  void setCarType(CarType carType) {
    final temp = state.selectedLoan!.copyWith(carType: carType);
    emit(
      state.copyWith(
        selectedLoan: temp,
      ),
    );
  }
}
