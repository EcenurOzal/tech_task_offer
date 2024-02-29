class DetailedLoanInstallment {
  int installmentNumber; // Taksit Numarası
  double installmentAmount; // Taksit Tutarı
  double principalAmount; // Anapara
  double interestAmount; // Faiz
  double kkdf; // KKDF (Katma Kıymetli Değer Fonu)
  double bsmv; // BSMV (Banka ve Sigorta Muameleleri Vergisi)
  double remainingPrincipal; // Kalan Anapara

  DetailedLoanInstallment({
    required this.installmentNumber,
    required this.installmentAmount,
    required this.principalAmount,
    required this.interestAmount,
    required this.kkdf,
    required this.bsmv,
    required this.remainingPrincipal,
  });

  DetailedLoanInstallment copyWith({
    int? installmentNumber,
    double? installmentAmount,
    double? principalAmount,
    double? interestAmount,
    double? kkdf,
    double? bsmv,
    double? remainingPrincipal,
  }) {
    return DetailedLoanInstallment(
      installmentNumber: installmentNumber ?? this.installmentNumber,
      installmentAmount: installmentAmount ?? this.installmentAmount,
      principalAmount: principalAmount ?? this.principalAmount,
      interestAmount: interestAmount ?? this.interestAmount,
      kkdf: kkdf ?? this.kkdf,
      bsmv: bsmv ?? this.bsmv,
      remainingPrincipal: remainingPrincipal ?? this.remainingPrincipal,
    );
  }
}
