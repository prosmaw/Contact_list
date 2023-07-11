import 'package:flutter/material.dart';

import '../details_screen.dart';
import 'profile_parameter.dart';

class AdressesColumn extends StatelessWidget {
  const AdressesColumn({
    super.key,
    required this.widget,
    required this.phoneController,
    required this.edit,
    required this.cellController,
    required this.streetNBController,
  });

  final DetailsScreen widget;
  final TextEditingController phoneController;
  final bool edit;

  final TextEditingController cellController;

  final TextEditingController streetNBController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileParameter(
          icon: Icons.smartphone,
          parameterName: 'Numero de téléphone',
          value: widget.contact.phone,
          controller: phoneController,
          edit: edit,
        ),
        const SizedBox(
          height: 10,
        ),
        //showing cell number
        ProfileParameter(
            icon: Icons.call,
            parameterName: 'Numero célulaire',
            value: widget.contact.phone,
            controller: cellController,
            edit: edit),
        const SizedBox(
          height: 10,
        ),
        //adresse
        ProfileParameter(
            icon: Icons.home,
            parameterName: edit ? "Num Rue" : "Adresse",
            value:
                "${widget.contact.streetNumber} ${widget.contact.streetName}, ${widget.contact.city}-${widget.contact.country}",
            controller: streetNBController,
            edit: edit),
      ],
    );
  }
}
