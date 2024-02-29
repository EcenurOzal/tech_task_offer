// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tech_task_offer/core/theme/text/app_text.dart';
import 'package:tech_task_offer/core/theme/text/font_weight.dart';

import '../../../core/core.dart';
import '../../../core/extension/extension.dart';
import '../../../data/repository/offer_repository.dart';
import '../../../locator.dart';
import '../home.dart';
import '../model/detailed_loan_installment.dart';
import '../model/model.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_radio_button.dart';
import '../widgets/custom_slider.dart';
import '../widgets/title_card.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        offerRepository: getIt<OfferRepository>(),
      )..init(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  late final String formattedDate;
  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    DateTime now = DateTime.now();
    formattedDate = DateFormat('d MMMM yyyy', 'tr_TR').format(now);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.event == HomeEvent.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppText.titleSmall(context, state.errorMessage!),
              animation: CurvedAnimation(
                parent: const AlwaysStoppedAnimation(2),
                curve: Curves.easeInOut,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawerScrimColor: Colors.black.withOpacity(0.9),
          endDrawer: _buildCustomDrawer(context, state),
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Teklifim Gelsin',
            ),
            actions: const [
              //? Hide Drawer Icon
              SizedBox.shrink(),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state.event == HomeEvent.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.event == HomeEvent.success) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.xMaterialColorTheme.onSurface
                          .withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range, size: 18),
                        AppPadding.xHorizontal8(),
                        AppText.bodyMedium(context, formattedDate),
                      ],
                    ),
                  ),
                ),

                //
                AppPadding.xHorizontal8(),

                //
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.xMaterialColorTheme.onSurface
                          .withOpacity(0.2),
                      border: Border.all(
                        color: context.xMaterialColorTheme.onSurface
                            .withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          //
                          const Icon(Icons.refresh_outlined, size: 18),

                          //
                          AppPadding.xHorizontal8(),

                          //
                          AppText.bodyMedium(context, 'Tekrar Hesapla'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //
            AppPadding.xVertical16(),

            //
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    if (state.activeOffers?.isNotEmpty ?? false) ...[
                      ListView.separated(
                        separatorBuilder: (context, index) =>
                            AppPadding.xVertical28(),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        itemCount: state.activeOffers?.length ?? 0,
                        itemBuilder: (context, index) {
                          //? Aylık Taksit Hesaplama
                          double mountlyPayment = calculateMonthlyPayment(
                            state.selectedLoan!.defaultAmount.toDouble(),
                            state.activeOffers![index].interestRate ?? 0.0,
                            state.selectedLoan!.defaultMaturity,
                          );

                          //? Taksit Listesi
                          List<DetailedLoanInstallment> installmentList =
                              createInstallmentList(
                            state.selectedLoan!.defaultAmount.toDouble(),
                            state.activeOffers![index].interestRate ?? 0.0,
                            state.selectedLoan!.defaultMaturity,
                          );
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: context.xMaterialColorTheme.onSurface
                                    .withOpacity(0.2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.bodyLarge(
                                    context,
                                    state.activeOffers![index].bank ?? "",
                                    fontWeight: AppFontWeight.v6,
                                  ),

                                  //
                                  AppPadding.xVertical8(),

                                  //
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleCard(
                                        title: "Aylık Taksit",
                                        subTitle:
                                            "₺${mountlyPayment.toStringAsFixed(2)}",
                                      ),
                                      TitleCard(
                                          title: "Faiz Oranı",
                                          subTitle: state.activeOffers![index]
                                              .interestRate!
                                              .toString()),
                                      TitleCard(
                                          title: "Toplam Maliyet",
                                          subTitle:
                                              "₺${((mountlyPayment * state.selectedLoan!.defaultMaturity) + 172.5).toStringAsFixed(2)}")
                                    ],
                                  ),

                                  //
                                  AppPadding.xVertical16(),

                                  InkWell(
                                    onTap: () {
                                      showLoanPopUp(
                                          context,
                                          installmentList,
                                          state.activeOffers![index],
                                          state.selectedLoan!,
                                          mountlyPayment);
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: context
                                              .xMaterialColorTheme.primary
                                              .withOpacity(0.8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: AppText.bodyMedium(
                                              context,
                                              'Detay',
                                              color: context.xMaterialColorTheme
                                                  .onPrimaryContainer,
                                              fontWeight: AppFontWeight.v6,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state.event == HomeEvent.failure) {
      return Center(
        child: AppText.displayMedium(context, 'Error'),
      );
    } else {
      return SizedBox.fromSize();
    }
  }

  Future<dynamic> showLoanPopUp(
      BuildContext context,
      List<DetailedLoanInstallment> installmentList,
      OffersModel model,
      LoanModel selectedLoan,
      double mountlyPayment) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  AppText.bodyLarge(context, model.bank ?? "",
                      color: context.xMaterialColorTheme.primary),

                  //
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TitleCard(
                        title: "Kredi Tutarı",
                        subTitle: "₺${selectedLoan.defaultAmount}",
                      ),
                      TitleCard(
                        title: "Taksit",
                        subTitle: "₺${mountlyPayment.toStringAsFixed(2)}",
                      ),
                      TitleCard(
                        title: "Faiz Oranı",
                        subTitle: model.interestRate.toString(),
                      ),
                      TitleCard(
                        title: "Vade",
                        subTitle: selectedLoan.defaultMaturity.toString(),
                      ),
                      TitleCard(
                          title: "Toplam Tutar",
                          subTitle:
                              "₺${((mountlyPayment * selectedLoan.defaultMaturity) + AppConst.masraf).toStringAsFixed(2)}"),
                      TitleCard(
                          title: "Masraf", subTitle: "₺${AppConst.masraf}"),
                    ],
                  ),

                  //
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: AppText.bodyLarge(
                        context,
                        'DETAYLI KREDI TAKSIT TABLOSU',
                        color: context.xMaterialColorTheme.primary,
                      ),
                    ),
                  ),

                  //
                  SingleChildScrollView(
                    key: const Key(''),
                    scrollDirection: Axis.horizontal,
                    child: _buildDataTable(installmentList),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DataTable _buildDataTable(List<DetailedLoanInstallment> installmentList) {
    return DataTable(
      columns: [
        DataColumn(label: AppText.bodyMedium(context, 'Taksit')),
        DataColumn(label: AppText.bodyMedium(context, 'Anapara')),
        DataColumn(label: AppText.bodyMedium(context, 'Faiz')),
        DataColumn(label: AppText.bodyMedium(context, 'KKDF')),
        DataColumn(label: AppText.bodyMedium(context, 'BSMV')),
        DataColumn(label: AppText.bodyMedium(context, 'Kalan Anapara')),
      ],
      rows: List.generate(installmentList.length, (index) {
        var installment = installmentList[index];
        return DataRow(
          cells: [
            DataCell(AppText.bodyMedium(
                context, '${installment.installmentNumber}')),
            DataCell(AppText.bodyMedium(
                context, '₺${installment.principalAmount.toStringAsFixed(2)}')),
            DataCell(AppText.bodyMedium(
                context, '₺${installment.interestAmount.toStringAsFixed(2)}')),
            DataCell(AppText.bodyMedium(
                context, '₺${installment.kkdf.toStringAsFixed(2)}')),
            DataCell(AppText.bodyMedium(
                context, '₺${installment.bsmv.toStringAsFixed(2)}')),
            DataCell(AppText.bodyMedium(context,
                '₺${installment.remainingPrincipal.toStringAsFixed(2)}')),
          ],
        );
      }),
    );
  }

  Widget _buildCustomDrawer(BuildContext context, HomeState state) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Center(
                  child: AppText.bodyLarge(
                    context,
                    "Tekrar Hesapla",
                    fontWeight: AppFontWeight.v6,
                  ),
                ),

                //
                AppPadding.xVertical8(),

                //
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.xMaterialColorTheme.onSurface
                          .withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.date_range, size: 18),
                        AppPadding.xHorizontal8(),
                        AppText.bodyLarge(
                          context,
                          formattedDate,
                        ),
                      ],
                    ),
                  ),
                ),

                //
                AppPadding.xVertical8(),

                //
                Center(
                  child: AppText.bodyLarge(
                    context,
                    "Arama Detayları",
                  ),
                ),

                //
                AppPadding.xVertical16(),
                //
                AppText.bodyMedium(
                  context,
                  "Kredi Tipi",
                  color: context.xMaterialColorTheme.onSurfaceVariant,
                  fontWeight: AppFontWeight.v6,
                ),
                //
                AppPadding.xVertical8(),

                //
                CustomDropDown(
                  selectedLoan: state.selectedLoan!,
                  loans: state.loans!,
                  onChanged: (value) {
                    context.read<HomeCubit>().setSelectedLoan(value);
                  },
                ),

                //
                AppPadding.xVertical8(),

                //
                if (state.selectedLoan!.loanType == LoanType.vehicleLoan) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      AppText.bodyMedium(
                        context,
                        "Araç Durumu:",
                        color: context.xMaterialColorTheme.onSurface,
                      ),

                      //
                      CustomRadioButton(
                        carType: CarType.newCar,
                        isSelected:
                            state.selectedLoan!.carType == CarType.newCar,
                        onTap: () {
                          context.read<HomeCubit>().setCarType(CarType.newCar);
                        },
                      ),

                      //
                      CustomRadioButton(
                        carType: CarType.secondHandCar,
                        isSelected: state.selectedLoan!.carType ==
                            CarType.secondHandCar,
                        onTap: () {
                          context
                              .read<HomeCubit>()
                              .setCarType(CarType.secondHandCar);
                        },
                      ),
                    ],
                  ),
                ],

                //
                AppPadding.xVertical8(),

                //
                AppText.bodyMedium(
                  context,
                  "Kredi Tutarı",
                  color: context.xMaterialColorTheme.onSurfaceVariant,
                  fontWeight: AppFontWeight.v6,
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.xMaterialColorTheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "₺${NumberFormat("#,##0", "tr_TR").format(state.selectedLoan!.defaultAmount)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.xMaterialColorTheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),

                //

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSlider(
                    stepValue: state.selectedLoan!.division.toDouble(),
                    max: state.selectedLoan!.maxAmount.toDouble(),
                    min: state.selectedLoan!.minAmount.toDouble(),
                    toggleColor: context.xMaterialColorTheme.primary,
                    defaultValue: state.selectedLoan!.defaultAmount.toDouble(),
                    onChanged: (double value) {
                      int roundedValue =
                          (value / state.selectedLoan!.division).round() *
                              state.selectedLoan!.division;

                      context.read<HomeCubit>().setSliderAmount(roundedValue);
                    },
                  ),
                ),

                //
                AppText.bodyMedium(
                  context,
                  "Kredi Vadesi",
                  color: context.xMaterialColorTheme.onSurfaceVariant,
                  fontWeight: AppFontWeight.v6,
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.xMaterialColorTheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AppText.bodyMedium(
                      context,
                      "${state.selectedLoan!.defaultMaturity} Ay",
                      color: context.xMaterialColorTheme.onPrimaryContainer,
                      fontWeight: AppFontWeight.v6,
                    ),
                  ),
                ),

                //

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomSlider(
                    stepValue: 1,
                    max: state.selectedLoan!.maxMaturity.toDouble(),
                    min: state.selectedLoan!.minMaturity.toDouble(),
                    toggleColor: context.xMaterialColorTheme.primary,
                    defaultValue:
                        state.selectedLoan!.defaultMaturity.toDouble(),
                    onChanged: (double value) {
                      context
                          .read<HomeCubit>()
                          .setSliderMaturity(value.toInt());
                    },
                  ),
                ),

                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.closeEndDrawer();
                    context.read<HomeCubit>().getOffers();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.xMaterialColorTheme.onSurface
                            .withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AppText.bodyMedium(context, 'Tekrar Hesapla'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double calculateMonthlyPayment(double amount, double rate, int term) {
  double monthlyInterestRate = rate * 0.013;
  double monthlyPayment =
      (amount * monthlyInterestRate * pow((1 + monthlyInterestRate), term)) /
          (pow((1 + monthlyInterestRate), term) - 1);
  return monthlyPayment;
}

List<DetailedLoanInstallment> createInstallmentList(
    double loanAmount, double rate, int term) {
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


