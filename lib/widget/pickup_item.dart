import 'package:flutter/material.dart';
import 'package:i_logistics/theme/color.dart';

import '../theme/styles.dart';

class PickupItem extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final Function buttonFunction;
  const PickupItem(
      {Key? key,
      required this.title,
      required this.buttonTitle,
      required this.buttonFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(fontWeight: FontWeight.w700),),
              RawMaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  fillColor: detailsColor,
                  shape: buttonShape,
                  onPressed: () {
                    buttonFunction.call();
                  },
                  child: Text(
                    buttonTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ))
            ],
          ),
        ),
        const Divider(thickness: 1,color: Colors.black,)
      ],
    );
  }
}
