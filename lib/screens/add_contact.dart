import 'package:dac_test/screens/widgets/profile_parameter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/contacts.dart';
import 'details_screen.dart';
import 'home_screen.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
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
  bool edit = true;
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileParameter(
                  icon: Icons.person,
                  parameterName: "Prenom",
                  value: "",
                  controller: firstController,
                  edit: edit),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                icon: Icons.person,
                parameterName: 'Nom de famille',
                value: "",
                controller: lastController,
                edit: edit,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                icon: Icons.smartphone,
                parameterName: 'Numero de téléphone',
                value: "",
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
                  value: "",
                  controller: cellController,
                  edit: edit),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                icon: Icons.mail,
                parameterName: 'Email',
                value: "",
                controller: emailController,
                edit: edit,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                  icon: Icons.home,
                  parameterName: "Num Rue",
                  value: "",
                  controller: streetNBController,
                  edit: edit),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                  icon: Icons.home,
                  parameterName: "Nom Rue",
                  value: "",
                  controller: streetNController,
                  edit: edit),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                  icon: Icons.home,
                  parameterName: "Ville",
                  value: "",
                  controller: cityController,
                  edit: edit),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                  icon: Icons.home,
                  parameterName: "Pays",
                  value: "",
                  controller: countryController,
                  edit: edit),
              const SizedBox(
                height: 10,
              ),
              ProfileParameter(
                  icon: Icons.cake,
                  parameterName: 'Date de naissance',
                  value: "",
                  controller: birthController,
                  edit: edit),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    addingContact(context);
                  },
                  child: Text(
                    "Enregistrer",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void addingContact(BuildContext context) async {
    int? size = await dbhelper.size(database);
    return setState(() {
      Contact ct = Contact(
          first: firstController.text,
          last: lastController.text,
          birthDate: birthController.text,
          email: emailController.text,
          id: size!,
          country: countryController.text,
          state: "",
          city: cityController.text,
          streetName: streetNController.text,
          streetNumber: int.parse(streetNBController.text),
          phone: phoneController.text,
          pictureLink: "");
      dbhelper.insertContact(ct, database);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  contact: ct,
                )),
      );
    });
  }
}
