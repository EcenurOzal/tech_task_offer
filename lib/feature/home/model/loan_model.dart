// ignore_for_file: public_member_api_docs, sort_constructors_first
enum LoanType {
  personalLoan(0),
  vehicleLoan(2),
  mortgageLoan(1);

  final int value;
  const LoanType(this.value);
}

extension LoanTypeExtension on LoanType {
  String get turkishName {
    switch (this) {
      case LoanType.personalLoan:
        return 'İhtiyaç Kredi';
      case LoanType.vehicleLoan:
        return 'Taşıt Kredisi';
      case LoanType.mortgageLoan:
        return 'Konut Kredisi';
      default:
        return 'Bilinmeyen Kredi Tipi';
    }
  }
}

enum CarType {
  secondHandCar(2),
  newCar(0);

  final int value;
  const CarType(this.value);
}

extension CarTypeExtension on CarType {
  String get turkishName {
    switch (this) {
      case CarType.newCar:
        return '0 Km';
      case CarType.secondHandCar:
        return '2. El';
      default:
        return 'Bilinmeyen';
    }
  }
}

class LoanModel {
  final LoanType loanType;
  final int maxAmount;
  final int minAmount;
  final int defaultAmount;
  final int maxMaturity;
  final int minMaturity;
  final int defaultMaturity;
  final CarType? carType;
  final int division;
  LoanModel({
    required this.loanType,
    required this.maxAmount,
    required this.minAmount,
    required this.defaultAmount,
    required this.maxMaturity,
    required this.minMaturity,
    required this.defaultMaturity,
    this.carType,
    required this.division,
  });

  LoanModel copyWith({
    LoanType? loanType,
    int? maxAmount,
    int? minAmount,
    int? defaultAmount,
    int? maxMaturity,
    int? minMaturity,
    int? defaultMaturity,
    CarType? carType,
    int? division,
  }) {
    return LoanModel(
      loanType: loanType ?? this.loanType,
      maxAmount: maxAmount ?? this.maxAmount,
      minAmount: minAmount ?? this.minAmount,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      maxMaturity: maxMaturity ?? this.maxMaturity,
      minMaturity: minMaturity ?? this.minMaturity,
      defaultMaturity: defaultMaturity ?? this.defaultMaturity,
      carType: carType ?? this.carType,
      division: division ?? this.division,
    );
  }

  @override
  bool operator ==(covariant LoanModel other) {
    if (identical(this, other)) return true;

    return other.loanType == loanType &&
        other.maxAmount == maxAmount &&
        other.minAmount == minAmount &&
        other.defaultAmount == defaultAmount &&
        other.maxMaturity == maxMaturity &&
        other.minMaturity == minMaturity &&
        other.defaultMaturity == defaultMaturity &&
        other.carType == carType &&
        other.division == division;
  }

  @override
  int get hashCode {
    return loanType.hashCode ^
        maxAmount.hashCode ^
        minAmount.hashCode ^
        defaultAmount.hashCode ^
        maxMaturity.hashCode ^
        minMaturity.hashCode ^
        defaultMaturity.hashCode ^
        carType.hashCode ^
        division.hashCode;
  }
}
