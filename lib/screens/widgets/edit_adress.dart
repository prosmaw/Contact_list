import 'package:flutter/material.dart';

import '../details_screen.dart';
import 'profile_parameter.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({
    super.key,
    required this.widget,
    required this.streetNController,
    required this.edit,
    required this.cityController,
    required this.countryController,
  });

  final DetailsScreen widget;
  final TextEditingController streetNController;
  final bool edit;

  final TextEditingController cityController;

  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileParameter(
            icon: Icons.home,
            parameterName: "Nom Rue",
            value: widget.contact.streetName,
            controller: streetNController,
            edit: edit),
        ProfileParameter(
            icon: Icons.home,
            parameterName: "Ville",
            value: widget.contact.city,
            controller: cityController,
            edit: edit),
        ProfileParameter(
            icon: Icons.home,
            parameterName: "Pays",
            value: widget.contact.country,
            controller: countryController,
            edit: edit),
      ],
    );
  }
}
