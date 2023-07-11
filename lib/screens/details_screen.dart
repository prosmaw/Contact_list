import 'package:dac_test/screens/home_screen.dart';
import 'package:dac_test/screens/widgets/profile_parameter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/contacts.dart';
import 'widgets/adresses_column.dart';
import 'widgets/edit_adress.dart';
import 'widgets/edit_email.dart';
import 'widgets/picture_name.dart';

class DetailsScreen extends StatefulWidget {
  final Contact contact;
  const DetailsScreen({super.key, required this.contact});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool edit = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController cellController = TextEditingController();
  TextEditingController streetNBController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController streetNController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                //picture container, name and email
                PictureName(widget: widget),
                const SizedBox(
                  height: 30,
                ),
                //showing textfield for name and email case editing true
                edit
                    ? EditNameEmail(
                        widget: widget,
                        firstController: firstController,
                        edit: edit,
                        lastController: lastController,
                        emailController: emailController,
                      )
                    : const SizedBox(),
                //showing tel, cell, others address
                AdressesColumn(
                    widget: widget,
                    phoneController: phoneController,
                    edit: edit,
                    cellController: cellController,
                    streetNBController: streetNBController),
                edit
                    ? EditAddress(
                        widget: widget,
                        streetNController: streetNController,
                        edit: edit,
                        cityController: cityController,
                        countryController: countryController)
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                // birthday
                ProfileParameter(
                    icon: Icons.cake,
                    parameterName: 'Date de naissance',
                    value: widget.contact.birthDate,
                    controller: birthController,
                    edit: edit),
                const SizedBox(
                  height: 15,
                ),
                edit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  edit = false;
                                });
                              },
                              child: Text(
                                "Annuler",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                savingModification(context);
                              },
                              child: Text(
                                "Enregistrer",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ))
                        ],
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                modification();
                              },
                              child: Text(
                                "Modifier",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                dbhelper.delete(widget.contact.id, database);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                );
                              },
                              child: Text(
                                "Supprimer",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void savingModification(BuildContext context) {
    return setState(() {
      edit = false;
      Contact ct = Contact(
          first: firstController.text,
          last: lastController.text,
          birthDate: birthController.text,
          email: emailController.text,
          id: widget.contact.id,
          country: countryController.text,
          state: widget.contact.state,
          city: cityController.text,
          streetName: streetNController.text,
          streetNumber: int.parse(streetNBController.text),
          phone: phoneController.text,
          pictureLink: widget.contact.pictureLink);
      dbhelper.update(ct, database);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  contact: ct,
                )),
      );
    });
  }

  void modification() {
    return setState(() {
      edit = true;
      phoneController = TextEditingController(text: widget.contact.phone);
      cellController = TextEditingController(text: widget.contact.phone);
      emailController = TextEditingController(text: widget.contact.email);
      firstController = TextEditingController(text: widget.contact.first);
      lastController = TextEditingController(text: widget.contact.last);
      streetNBController =
          TextEditingController(text: "${widget.contact.streetNumber}");
      birthController = TextEditingController(text: widget.contact.birthDate);
      streetNController =
          TextEditingController(text: widget.contact.streetName);
      cityController = TextEditingController(text: widget.contact.city);
      countryController = TextEditingController(text: widget.contact.country);
    });
  }
}
