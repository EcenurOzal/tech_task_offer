import 'package:flutter/material.dart';
import '../../../core/extension/extension.dart';

import '../model/loan_model.dart';

class CustomDropDown extends StatefulWidget {
  final LoanModel selectedLoan;
  final List<LoanModel> loans;
  final Function onChanged;

  const CustomDropDown({
    Key? key,
    required this.selectedLoan,
    required this.loans,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool _isExpanded = false;

  void _togglePanel() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 48.0;
    final double calculatedHeight = widget.loans.length * itemHeight;

    return Column(
      children: [
        GestureDetector(
          onTap: _togglePanel,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: context.xMaterialColorTheme.primaryContainer,
              borderRadius: _isExpanded
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    )
                  : BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedLoan.loanType.turkishName,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold, color: context.xMaterialColorTheme.onPrimaryContainer),
                ),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: context.xMaterialColorTheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          height: _isExpanded ? calculatedHeight : 0, // Dinamik yükseklik
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.xMaterialColorTheme.primaryContainer,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.loans
                  .map((element) => InkWell(
                        onTap: () {
                          widget.onChanged(element);
                          _togglePanel();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            element.loanType.turkishName,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: context.xMaterialColorTheme.onPrimaryContainer),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
