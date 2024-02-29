// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tech_task_offer/core/extension/extension.dart';

import '../model/loan_model.dart';

class CustomRadioButton extends StatelessWidget {
  final CarType carType;
  final bool isSelected;
  final Function()? onTap;

  const CustomRadioButton({
    Key? key,
    required this.carType,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: isSelected
              ? context.xMaterialColorTheme.primary
              : context.xMaterialColorTheme.primaryContainer,
        ),

        //
        AppPadding.xHorizontal8(),

        //
        Text(
          carType.turkishName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: context.xMaterialColorTheme.onSurface,
          ),
        ),
      ]),
    );
  }
}
