import '../../feature/home/model/loan_model.dart';

class AppConst {
  AppConst._();

  static String appName = "Tech Task";
  static double masraf = 172.5;

  static LoanModel personalLoan = LoanModel(
    loanType: LoanType.personalLoan,
    maxAmount: 300000,
    minAmount: 1000,
    defaultAmount: 30000,
    maxMaturity: 36,
    minMaturity: 1,
    defaultMaturity: 36,
    division: 1000,
  );

  static LoanModel vehicleLoan = LoanModel(
      loanType: LoanType.vehicleLoan,
      maxAmount: 400000,
      minAmount: 50000,
      defaultAmount: 280000,
      maxMaturity: 48,
      minMaturity: 1,
      defaultMaturity: 24,
      carType: CarType.newCar,
      division: 10000);

  static LoanModel mortgageLoan = LoanModel(
    loanType: LoanType.mortgageLoan,
    maxAmount: 5000000,
    minAmount: 100000,
    defaultAmount: 1000000,
    maxMaturity: 240,
    minMaturity: 1,
    defaultMaturity: 120,
    division: 50000,
  );
}
