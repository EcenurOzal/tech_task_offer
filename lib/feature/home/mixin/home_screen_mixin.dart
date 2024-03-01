import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task_offer/feature/home/model/detailed_loan_installment.dart';
import 'package:tech_task_offer/feature/home/view/home_screen.dart';

mixin HomeScreenMixin on State<HomeView> {
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final String formattedDate;
  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    DateTime now = DateTime.now();
    formattedDate = DateFormat('d MMMM yyyy', 'tr_TR').format(now);
    super.initState();
  }

  double calculateMonthlyPayment(double amount, double rate, int term) {
    double monthlyInterestRate = rate * 0.013;
    double monthlyPayment = (amount * monthlyInterestRate * pow((1 + monthlyInterestRate), term)) /
        (pow((1 + monthlyInterestRate), term) - 1);
    return monthlyPayment;
  }

  List<DetailedLoanInstallment> createInstallmentList(double loanAmount, double rate, int term) {
    //?TAKSİTLER
    List<DetailedLoanInstallment> installments = [];

    //? Aylık Taksit Hesaplama
    double monthlyPayment = calculateMonthlyPayment(loanAmount, rate, term);

    //? Kalan Anapara
    double remainingPrincipal = loanAmount;

    //? FAİZ = Anapara * faizoranı /100

    for (int month = 1; month <= term; month++) {
      //? faiz ödemesi
      double interestPayment = remainingPrincipal * rate / 100;

      //? Anapara ödemesi
      double kkdf = interestPayment * 0.15; //! KKDF oranı %15
      double bsmv = interestPayment * 0.15; //!  BSMV oranı %15
      double principalPayment = monthlyPayment - interestPayment - kkdf - bsmv;

      //? Kalan anapara
      remainingPrincipal -= principalPayment;

      DetailedLoanInstallment installment = DetailedLoanInstallment(
          installmentNumber: month,
          installmentAmount: monthlyPayment,
          principalAmount: principalPayment,
          interestAmount: interestPayment,
          kkdf: kkdf,
          bsmv: bsmv,
          remainingPrincipal: remainingPrincipal);

      installments.add(installment);
    }

    return installments;
  }
}
