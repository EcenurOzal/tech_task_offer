part of 'home_cubit.dart';

enum HomeEvent {
  initial,
  loading,
  success,
  failure,
}

class HomeState {
  final HomeEvent event;
  final String? errorMessage;
  final OffersResponse? offers;
  final List<OffersModel>? activeOffers;
  final List<SponsoredOffers>? sponsoredOffers;
  final List<LoanModel>? loans;
  final LoanModel? selectedLoan;

  const HomeState({
    this.event = HomeEvent.initial,
    this.errorMessage,
    this.offers,
    this.activeOffers,
    this.sponsoredOffers,
    this.loans,
    this.selectedLoan,
  });

  HomeState copyWith({
    HomeEvent? event,
    String? errorMessage,
    OffersResponse? offers,
    List<OffersModel>? activeOffers,
    List<SponsoredOffers>? sponsoredOffers,
    List<LoanModel>? loans,
    LoanModel? selectedLoan,
  }) {
    return HomeState(
      event: event ?? this.event,
      errorMessage: errorMessage ?? this.errorMessage,
      offers: offers ?? this.offers,
      activeOffers: activeOffers ?? this.activeOffers,
      sponsoredOffers: sponsoredOffers ?? this.sponsoredOffers,
      loans: loans ?? this.loans,
      selectedLoan: selectedLoan ?? this.selectedLoan,
    );
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.event == event &&
        other.errorMessage == errorMessage &&
        other.offers == offers &&
        other.activeOffers == activeOffers &&
        other.sponsoredOffers == sponsoredOffers &&
        other.loans == loans &&
        other.selectedLoan == selectedLoan;
  }

  @override
  int get hashCode =>
      event.hashCode ^
      errorMessage.hashCode ^
      offers.hashCode ^
      activeOffers.hashCode ^
      sponsoredOffers.hashCode ^
      loans.hashCode ^
      selectedLoan.hashCode;
}
